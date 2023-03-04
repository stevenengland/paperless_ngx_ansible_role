# Changelog

## 0.4.0 - 2023-02-27

### paperless-ngx ansible role 0.4.0

#### Features

- feat: Add option to put system user to more groups @stevenengland ([#81](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/81))

#### Bug Fixes

- fix(preparation): check ansible version on the controller node @stevenengland ([#78](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/78))
- fix(finalizer): make finalize step run always @stevenengland ([#76](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/76))

#### Documentation

<details>
<summary>4 changes</summary>
- docs(readme): add hint that project is going to be transferred @stevenengland ([#80](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/80))
- docs: minor improvements to readme and contribute file @stevenengland ([#77](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/77))
- docs(readme): minor improvements @stevenengland ([#69](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/69))
- docs(readme): fix minor mistakes @stevenengland ([#63](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/63))

</details>
#### Maintenance

<details>
<summary>11 changes</summary>
- refactor(preparation): make prep steps run always via always tag @stevenengland ([#82](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/82))
- ci(test): add timeout to galaxy install command @stevenengland ([#79](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/79))
- refactor: add success_msg to assertions @stevenengland ([#75](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/75))
- ci(maint.): fix venv detection in maint. script @stevenengland ([#73](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/73))
- ci(requirements): add colorama @stevenengland ([#74](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/74))
- ci(linting): remove linting from test wf;add linting wf trigger @stevenengland ([#71](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/71))
- ci(python venv): add requirements.txt @stevenengland ([#70](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/70))
- refactor(naming): rename files and task names @stevenengland ([#68](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/68))
- test: use dafault preparation and verification tasks @stevenengland ([#67](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/67))
- ci: add postgresql db scenario @stevenengland ([#66](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/66))
- ci(test): add exclusions to path ignore in wf @stevenengland ([#64](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/64))

</details>
**Full Changelog**: https://github.com/stevenengland/paperless_ngx_ansible_role/compare/0.3.3...0.4.0

## 0.3.3 - 2023-02-21

### paperless-ngx ansible role 0.3.3

#### Maintenance

- ci(changelog): fix base branch in PR creation step @stevenengland ([#61](https://github.com/stevenengland/paperless_ngx_ansible_role/pull/61))

**Full Changelog**: https://github.com/stevenengland/paperless_ngx_ansible_role/compare/0.3.2...0.3.3
