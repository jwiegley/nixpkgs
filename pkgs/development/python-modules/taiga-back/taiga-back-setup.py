#!/usr/bin/env python
# -*- coding: utf-8 -*-

from setuptools import setup, find_packages

setup(
    name = 'taiga-back',
    version = '3.1.0',
    description = 'Project management web application with scrum in mind',
    long_description = '',
    keywords = 'taiga',
    author = 'taiga.io',
    author_email = 'support@taiga.io',
    url = 'https://taiga.io',
    license = 'AGPL',
    include_package_data = True,
    packages = find_packages('.'),
    # TODO are these required to be this explicit ? oO
    package_data = {
        '': [
            '*.png',
            '*.jinja',
            '*.json',
            '*.po',
            '*.txt',
            'base/static/emails/*.png',
            'base/static/img/emojis/*.png',
            'base/templates/emails/*.jinja',
            'export_import/templates/emails/*.jinja',
            'feedback/templates/emails/*.jinja',
            'importers/templates/emails/*.jinja',
            'projects/contact/templates/emails/*.jinja',
            'projects/fixtures/*.json',
            'projects/history/templates/emails/includes/*.jinja',
            'projects/management/commands/sample_data/*.txt',
            'projects/notifications/templates/emails/epics/*.jinja',
            'projects/notifications/templates/emails/issues/*.jinja',
            'projects/notifications/templates/emails/milestones/*.jinja',
            'projects/notifications/templates/emails/tasks/*.jinja',
            'projects/notifications/templates/emails/userstories/*.jinja',
            'projects/notifications/templates/emails/wiki/*.jinja',
            'projects/templates/emails/*.jinja',
            'users/fixtures/*.json',
            'users/static/img/*.png',
            'users/templates/emails/*.jinja',
        ],
    },
    scripts = ['manage.py'],
    install_requires=[
        'amqp',
        'asana',
        'bleach',
        'cairosvg',
        'celery',
        'cryptography',
        'cssutils',
        'diff-match-patch',
        'django',
        'django-ipware',
        'django-jinja',
        'django-pglocks',
        'django-picklefield',
        'django-sampledatahelper',
        'django-sites',
        'django-sr',
        'djmail',
        'easy-thumbnails',
        'fn',
        'gunicorn',
        'html5lib',
        'jinja2',
        'lxml',
        'Markdown',
        'netaddr',
        'pillow',
        'premailer',
        'psd-tools',
        'psycopg2',
        'pygments',
        'pyjwkest',
        'pyjwt',
        'python-dateutil',
        'python-magic',
        'pytz',
        'raven',
        'redis',
        'requests',
        'requests-oauthlib',
        'serpy',
        'six',
        'unidecode',
        'webcolors', 
    ],
    setup_requires = [],
)
