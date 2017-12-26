import os
import re
import requests
import sys

def version_to_list(version):
	return list(map(int, version.split('.')))

def odd_unstable(version, selected):
	if len(version) < 2:
		return True

	even = version[1] % 2 == 0
	if selected == 'stable':
		return even
	else:
		return not even

def any_version(version, selected):
	return True

version_policies = {
	'odd-unstable': odd_unstable,
	'any': any_version,
}

def make_version_policy(version_predicate, selected):
	return lambda version: version_predicate(version, selected)

version_pattern = re.compile(r'(?<=<a href=")\d+(?:\.\d+)*(?=/"><img)')
latest_pattern = re.compile(r'(?<=<a href="LATEST-IS-)\d+(?:\.\d+)*(?="><img)')

def value_in(value, allowed_values, label):
	if value not in allowed_values:
		options = ', '.join(allowed_values)
		print('{} must be one of {}; it is {} instead.'.format(label, options, value), file=sys.stderr)
		sys.exit(1)

if 'packageName' not in os.environ:
	print('Missing packageName environment variable.', file=sys.stderr)
	sys.exit(1)
package_name = os.environ['packageName']

requested_release = os.environ.get('requestedRelease', 'stable')
value_in(requested_release, ['stable', 'unstable'], 'Requested release')

version_policy_name = os.environ.get('versionPolicy', 'odd-unstable')
value_in(version_policy_name, version_policies.keys(), 'Version policy')
version_predicate = version_policies[version_policy_name]
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
