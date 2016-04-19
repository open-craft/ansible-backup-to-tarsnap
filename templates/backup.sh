#!/usr/bin/env bash

# Logic is as follows:

# 1. If pre-script fails exit immediately
# 2. Proceed if backup
# 3. Irrespective whether backup succeeds execute post-script.

timestamp=$(date -Isecond)

{% if TARSNAP_BACKUP_PRE_SCRIPT %}
{{ TARSNAP_BACKUP_PRE_SCRIPT }} || exit 1
{% endif %}

/usr/local/bin/tarsnap -c --keyfile "{{ TARSNAP_KEY_REMOTE_LOCATION }}" \
--cachedir "{{ TARSNAP_CACHE }}"  -f "{{ TARSNAP_ARCHIVE_NAME }}-${timestamp}" \
"{{ TARSNAP_BACKUP_FOLDERS }}" {% if TARSNAP_BACKUP_SNITCH %} && curl {{ TARSNAP_BACKUP_SNITCH }} {% endif %}

{% if TARSNAP_BACKUP_POST_SCRIPT %}{{ TARSNAP_BACKUP_POST_SCRIPT }}{% endif %}
