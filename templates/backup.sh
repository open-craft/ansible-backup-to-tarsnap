#!/usr/bin/env bash

timestamp = $(date -Isecond)

{% if TARSNAP_PRE_BACKUP_SCRIPT_REMOTE_LOCATION %}
    {{ TARSNAP_PRE_BACKUP_SCRIPT_REMOTE_LOCATION }} || exit 1
{% endif %}

/usr/local/bin/tarsnap -c --keyfile "{{ TARSNAP_KEY_REMOTE_LOCATION }}" \
--cachedir "{{ TARSNAP_CACHE }}"  -f "{{ TARSNAP_ARCHIVE_NAME }}-${timestamp}" \
"{{ TARSNAP_BACKUP_FOLDERS }}" {% if TARSNAP_BACKUP_SNITCH %} && curl {{ TARSNAP_BACKUP_SNITCH }} {% endif %}

{{ TARSNAP_POST_BACKUP_SCRIPT_REMOTE_LOCATION }}