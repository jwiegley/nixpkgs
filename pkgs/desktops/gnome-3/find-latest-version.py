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

def make_version_policy(version_predicate, selected):
	return lambda version: version_predicate(version, selected)

version_pattern = re.compile(r'(?<=<a href=")\d+(?:\.\d+)*(?=/"><img)')
latest_pattern = re.compile(r'(?<=<a href="LATEST-IS-)\d+(?:\.\d+)*(?="><img)')

if len(sys.argv) < 2:
	print('No arguments passed.', file=sys.stderr)
	sys.exit(1)
elif len(sys.argv) == 2:
	version_policy = make_version_policy(odd_unstable, 'stable')
	package_name = sys.argv[1]
elif len(sys.argv) == 3:
	package_name = sys.argv[1]

	if sys.argv[2] not in ['stable', 'unstable']:
		print('Requsted release must be either stable or unstable.', file=sys.stderr)
		sys.exit(1)

	version_policy = make_version_policy(odd_unstable, sys.argv[2])
elif len(sys.argv) == 4:
	package_name = sys.argv[1]

	if sys.argv[2] not in ['stable', 'unstable']:
		print('Requsted release must be either stable or unstable.', file=sys.stderr)
		sys.exit(1)

	if sys.argv[3] == 'odd-unstable':
		version_predicate = odd_unstable
	elif sys.argv[3] == 'any':
		version_predicate = any_version
	else:
		print('Requsted version policy must be one of odd-unstable or any.', file=sys.stderr)
		sys.exit(1)

	version_policy = make_version_policy(version_predicate, sys.argv[2])
else:
	print('Too many arguments passed.', file=sys.stderr)
	sys.exit(1)


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
