[![Tests](https://github.com/stevenengland/paperless_ngx_ansible_role/actions/workflows/tests.yml/badge.svg)](https://github.com/stevenengland/paperless_ngx_ansible_role/actions/workflows/tests.yml)

Role Name
=========

A brief description of the role goes here.

Requirements
------------

No special system requirements. Ansible 2.8 or newer is required.

Role Variables
--------------

Most configuration variables from paperless-ngx itself are available and accept their respective arguments.
Every `PAPERLESS_*` configuration variable is lowercased and instead prefixed with `paperless_ngx_conf_*` in `defaults/main.yml`.

For a full listing including explanations and allowed values, see the current [documentation](https://docs.paperless-ngx.com/configuration/).

Additional variables available in this role are listed below, along with default values:
```paperless_ngx_version: latest```

### Role specific variables

| Name           | Default Value | Description                        |
| -------------- | ------------- | -----------------------------------|
| `paperless_ngx_backup_on_upgrade` | true | Whether to backup old installation files before upgrade. |
| `paperless_ngx_db_type` | sqlite | Available db types are sqlite and postgresql. If postrgresql is chosen then the other db_ vars must be configured too. |
| `paperless_ngx_dir_export` | "{{ paperless_ngx_dir_runtime_data }}/export" | The dir where the exports are written to. |
| `paperless_ngx_dir_force_permission_exclude` | [] | Which directories should be skipped from permission check/setting. See [docs](docs/DIRECTORY_PERMISSION_CHECK.md). |
| `paperless_ngx_dir_installation` | /opt/paperless-ngx | The directory where paperless-ngx static installation files are written to. |
| `paperless_ngx_dir_runtime_data` | /var/lib/paperless-ngx | The directory where the runtime data will be stored. |
| `paperless_ngx_dir_virtualenv` | "{{ paperless_ngx_dir_installation }}/.venv" | The directory for the needed python venv. |
| `paperless_ngx_jbig2enc_enabled` | true | Whether to install and use jbig2enc for OCRmyPDF. |
| `paperless_ngx_jbig2enc_lossy` | false | Run jbig2enc in lossy mode or not. |
| `paperless_ngx_jbig2enc_tmp_dir` | /tmp/ | Directory for temporary jbig2enc files |
| `paperless_ngx_jbig2enc_version` | 0.29 | Which version to install. |
| `paperless_ngx_redis_host` | localhost | Redis host |
| `paperless_ngx_redis_port` | 6379 | Redis port |
| `paperless_ngx_system_group` | paperlessngx | The group to which the system user belongs. |
| `paperless_ngx_system_user` | paperlessngx | The user that will execute the services and own the data. |
| `paperless_ngx_version` | latest | Sofware version to install. Use `latest` or any specific version in the format `'1.10.0'`. Only versions >= 1.10.x supported. |
| `` |  |  |

### paperless-ngx configuration variables

#### Required services

| Name           | Default Value |
| -------------- | ------------- |
| `paperless_ngx_conf_redis` | not implemented, see system vars instead |
| `paperless_ngx_conf_dbengine` | not implemented, see system vars instead |
| `paperless_ngx_conf_dbhost` |  |
| `paperless_ngx_conf_dbport` |  |
| `paperless_ngx_conf_dbname` |  |
| `paperless_ngx_conf_dbuser` |  |
| `paperless_ngx_conf_dbpass` |  |
| `paperless_ngx_conf_dbsslmode` |  |
| `paperless_ngx_conf_db_timeout` |  |

#### Path and folders

| Name           | Default Value |
| -------------- | ------------- |
| `paperless_ngx_conf_consumption_dir` | "{{ paperless_ngx_dir_runtime_data }}/consumption" |
| `paperless_ngx_conf_data_dir` | "{{ paperless_ngx_dir_runtime_data }}/data" |
| `paperless_ngx_conf_trash_dir` | "{{ paperless_ngx_dir_runtime_data }}/trash" |
| `paperless_ngx_conf_media_root` | "{{ paperless_ngx_dir_runtime_data }}/media" |
| `paperless_ngx_conf_filename_format` | "" |
| `paperless_ngx_conf_filename_format_remove_none` | not implemented |
| `paperless_ngx_conf_logging_dir` | "{{ paperless_ngx_dir_runtime_data }}/log" |
| `paperless_ngx_conf_nltk_dir` | not implemented |

#### Logging

| Name           | Default Value |
| -------------- | ------------- |
| `paperless_ngx_conf_logrotate_max_size` |  |
| `paperless_ngx_conf_logrotate_max_backups` |  |

#### Hosting & Security

| Name           | Default Value |
| -------------- | ------------- |
| `paperless_ngx_conf_secret_key` |  |
| `paperless_ngx_conf_url` |  |
| `paperless_ngx_conf_csrf_trusted_origins` |  |
| `paperless_ngx_conf_allowed_hosts` |  |
| `paperless_ngx_conf_cors_allowed_hosts` |  |
| `paperless_ngx_conf_force_script_name` |  |
| `paperless_ngx_conf_static_url` |  |
| `paperless_ngx_conf_auto_login_username` |  |
| `paperless_ngx_conf_admin_user` |  |
| `paperless_ngx_conf_admin_mail` |  |
| `paperless_ngx_conf_admin_password` |  |
| `paperless_ngx_conf_cookie_prefix` |  |
| `paperless_ngx_conf_enable_http_remote_user` |  |
| `paperless_ngx_conf_http_remote_user_header_name` |  |
| `paperless_ngx_conf_logout_redirect_url` |  |

#### OCR settings

| Name           | Default Value |
| -------------- | ------------- |
| `paperless_ngx_conf_ocr_language` | not implemented, see system vars instead |
| `paperless_ngx_conf_ocr_mode` |  |
| `paperless_ngx_conf_ocr_clean` |  |
| `paperless_ngx_conf_ocr_deskew` |  |
| `paperless_ngx_conf_ocr_rotate_pages` |  |
| `paperless_ngx_conf_ocr_rotate_pages_threshold` |  |
| `paperless_ngx_conf_ocr_output_type` |  |
| `paperless_ngx_conf_ocr_pages` |  |
| `paperless_ngx_conf_ocr_image_dpi` |  |
| `paperless_ngx_conf_ocr_max_image_pixels` |  |
| `paperless_ngx_conf_ocr_user_args` |  |

#### Tika settings

| Name           | Default Value |
| -------------- | ------------- |
| `paperless_ngx_conf_tika_enabled` |  |
| `paperless_ngx_conf_tika_endpoint` |  |
| `paperless_ngx_conf_tika_gotenberg_endpoint` |  |

#### Software tweaks

| Name           | Default Value |
| -------------- | ------------- |
| `paperless_ngx_conf_task_workers` |  |
| `paperless_ngx_conf_threads_per_worker` |  |
| `paperless_ngx_conf_worker_timeout` |  |
| `paperless_ngx_conf_worker_retry` |  |
| `paperless_ngx_conf_time_zone` |  |
| `paperless_ngx_conf_enable_nltk` |  |
| `paperless_ngx_conf_email_task_cron` |  |
| `paperless_ngx_conf_train_task_cron` |  |
| `paperless_ngx_conf_index_task_cron` |  |
| `paperless_ngx_conf_sanity_task_cron` |  |

#### Polling

| Name           | Default Value |
| -------------- | ------------- |
| `paperless_ngx_conf_consumer_polling` |  |
| `paperless_ngx_conf_consumer_polling_retry_count` |  |
| `paperless_ngx_conf_consumer_polling_delay` |  |

#### iNotify

| Name           | Default Value |
| -------------- | ------------- |
| `paperless_ngx_conf_consumer_inotify_delay` |  |
| `paperless_ngx_conf_consumer_delete_duplicates` |  |
| `paperless_ngx_conf_consumer_recursive` |  |
| `paperless_ngx_conf_consumer_subdirs_as_tags` |  |
| `paperless_ngx_conf_consumer_enable_barcodes` |  |
| `paperless_ngx_conf_consumer_barcode_tiff_support` |  |
| `paperless_ngx_conf_consumer_enable_asn_barcode` |  |
| `paperless_ngx_conf_convert_memory_limit` |  |
| `paperless_ngx_conf_convert_tmpdir` |  |
| `paperless_ngx_conf_post_consume_script` |  |
| `paperless_ngx_conf_filename_date_order` |  |
| `paperless_ngx_conf_number_of_suggested_dates` |  |
| `paperless_ngx_conf_thumbnail_font_name` |  |
| `paperless_ngx_conf_ignore_dates` |  |
| `paperless_ngx_conf_date_order` |  |
| `paperless_ngx_conf_consumer_ignore_patterns` |  |

#### Binaries

| Name           | Default Value |
| -------------- | ------------- |
| `paperless_ngx_conf_convert_binary` |  |
| `paperless_ngx_conf_gs_binary` |  |

#### Docker specicif options

| Name           | Default Value |
| -------------- | ------------- |
| `paperless_ngx_conf_webserver_workers` |  |
| `paperless_ngx_conf_bind_addr` |  |
| `paperless_ngx_conf_port` |  |
| `paperless_ngx_conf_usermap_uid` |  |
| `paperless_ngx_conf_usermap_gid` |  |
| `paperless_ngx_conf_ocr_languages` |  |
| `paperless_ngx_conf_enable_flower` |  |

#### Update Checking

| Name           | Default Value |
| -------------- | ------------- |
| `paperless_ngx_conf_enable_update_check` |  |

### Usage advice

#### Separation of static (~ installation) and dynamic (~ runtime) data

This role checks that you do not set one of the data dirs (like consumption etc.) as a subdirectory of the installation path. For making my life easier this role deletes the installation folder and creates a complete new one when upgrading. This is fresh and clean. Also this way you are kept from unwanted deletions of your data during upgrades.

Dependencies
------------

There is a dependency on `jmespath`. This is included as part of the community.general collection within ansible. Please follow this link for more information - https://docs.ansible.com/ansible/latest/user_guide/playbooks_filters.html#selecting-json-data-json-queries

Example Playbooks
----------------

`minimal_runnable_playbook.yml`:

```
- hosts: all
    become: yes
    roles:
        - { role: stevenengland.paperless_ngx_ansible_role,  tags: ["paperless"] }
    vars:
        var1:
        var2:
        ...
```

Contributing
-------

We encourage you to contribute to this role! Please check out the
[contributing guide](CONTRIBUTE.md) for guidelines about how to proceed.

License
-------

MIT
