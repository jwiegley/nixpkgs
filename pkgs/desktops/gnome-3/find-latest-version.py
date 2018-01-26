import argparse
import re
import requests
import sys

def version_to_list(version):
	return list(map(int, version.split('.')))

def odd_unstable(version_str, selected):
	version = version_to_list(version_str)
	if len(version) < 2:
		return True

	even = version[1] % 2 == 0
	if selected == 'stable':
		return even
	else:
		return not even

def no_policy(version, selected):
	return True

version_policies = {
	'odd-unstable': odd_unstable,
	'none': no_policy,
}

def make_version_policy(version_predicate, selected):
	return lambda version: version_predicate(version, selected)

version_pattern = re.compile(r'(?<=<a href=")\d+(?:\.\d+)*(?=/"><img)')
latest_pattern = re.compile(r'(?<=<a href="LATEST-IS-)\d+(?:\.\d+)*(?="><img)')

parser = argparse.ArgumentParser(description='Find latest version for a GNOME package by crawling their release server.')
parser.add_argument('package-name', help='Name of the directory in https://ftp.gnome.org/pub/GNOME/sources/ containing the package.')
parser.add_argument('version-policy', help='Policy determining which versions are considered stable. For most GNOME packages, odd minor versions are unstable but there are exceptions.', choices=version_policies.keys(), nargs='?', default='odd-unstable')
parser.add_argument('requested-release', help='Most of the time, we will want to update to stable version but sometimes it is useful to test.', choices=['stable', 'unstable'], nargs='?', default='stable')


if __name__ == '__main__':
	args = parser.parse_args()

	package_name = getattr(args, 'package-name')
	requested_release = getattr(args, 'requested-release')
	version_predicate = version_policies[getattr(args, 'version-policy')]
	version_policy = make_version_policy(version_predicate, requested_release)

	versions = [ version.group(0) for version in version_pattern.finditer(requests.get('https://ftp.gnome.org/pub/GNOME/sources/{}/'.format(package_name)).text) ]

	versions = sorted(filter(version_policy, versions), key=version_to_list)

	if len(versions) == 0:
		print('No versions matched.', file=sys.stderr)
		sys.exit(1)

	version_branch = versions[-1]
	latest_version = latest_pattern.search(requests.get('https://ftp.gnome.org/pub/GNOME/sources/{}/{}/'.format(package_name, version_branch)).text)

	if not latest_version:
		print('Missing LATEST-IS file.', file=sys.stderr)
		sys.exit(1)

	print(latest_version.group(0))
