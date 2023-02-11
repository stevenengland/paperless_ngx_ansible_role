#!/bin/bash

# Read opts
while getopts d:v flag
do
    case "${flag}" in
        d) diff_scenario=${OPTARG};;
        v) verbose=true;;
    esac
done

# Get global vars
dir=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)

config_docs_html_body=$(curl -sb -L -H "Accept: text/plain; charset=utf-8" "https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/docs/configuration.md")
config_readme_md_body=$(<$dir/../README.md)
config_default_vars_yaml_body=$(<$dir/../defaults/main.yml)
config_vars_yaml_body=$(<$dir/../vars/main.yml)
config_vars_complete_yaml_body="$config_default_vars_yaml_body"$'\n'"$config_vars_yaml_body"

exclude_conf_options=(
    # Docker container options not affected by paperless.conf
    "PAPERLESS_WEBSERVER_WORKERS",
    "PAPERLESS_BIND_ADDR",
    "PAPERLESS_PORT",
    "USERMAP_UID",
    "USERMAP_GID",
    # "PAPERLESS_OCR_LANGUAGES", # also used in bare metal installation
    "PAPERLESS_ENABLE_FLOWER"
)

# README vs. DOCS
# Get vars from docs (without prefix)
pattern_for_docs="\`(?:PAPERLESS_)?(.*?)=<.*>\`"
matches_in_docs=( $(echo "$config_docs_html_body" | pcregrep -o1 $pattern_for_docs) )

# Get conf vars from readme (without prefix)
pattern_for_readme_conf_only="\|\s*\`paperless_ngx_conf_(.*?)\`\s*|"
matches_in_readme_conf_only=( $(echo "$config_readme_md_body" | pcregrep -o1 $pattern_for_readme_conf_only) )

# README vs. VARS
# Get all vars from readme
pattern_for_readme="\|\s*\`(paperless_ngx_.*?)\`\s*|"
matches_in_readme=( $(echo "$config_readme_md_body" | pcregrep -o1 $pattern_for_readme) )

# Get all vars from defaults var file
pattern_for_default_vars="^(paperless_ngx_.*?):"
matches_in_default_vars=( $(echo "$config_default_vars_yaml_body" | pcregrep -o1 $pattern_for_default_vars) )

# ??? vs ???
# Get conf vars from local var files (may be spread over multiple files)
pattern_for_vars_conf_only="^paperless_ngx_conf_(.*?):"
matches_in_vars_conf_only=( $(echo "$config_vars_complete_yaml_body" | pcregrep -o1 $pattern_for_vars_conf_only) )

# Get all vars from local var files
pattern_for_vars="^paperless_ngx_(.*?):"
matches_in_vars=( $(echo "$config_vars_complete_yaml_body" | pcregrep -o1 $pattern_for_vars) )

#############################################
# DOCS vs README
# - What:   Do not miss a new feature var or deprecated var
# - How:    Compare DOCS complete var set with roles README conf vars that correspond with DOCS.
#############################################
in_docs_but_not_in_readme=()
for item1 in "${matches_in_docs[@]}"; do
    for item2 in "${matches_in_readme_conf_only[@]}"; do
        [[ ${item1^^} == "${item2^^}" ]] && continue 2
    done

    # If we reached here, nothing matched.
    in_docs_but_not_in_readme+=( "$item1" )
done

in_readme_but_not_in_docs=()
for item1 in "${matches_in_readme_conf_only[@]}"; do
    for item2 in "${matches_in_docs[@]}"; do
        [[ ${item1^^} == "${item2^^}" ]] && continue 2
    done

    # If we reached here, nothing matched.
    in_readme_but_not_in_docs+=( "$item1" )
done

#############################################
# VARS (defaults only) vs README
# - What:   Every var in defaults should be documented in README because they are ment to be overridden by the user.
# - How:    Compare VARS defaults with roles README complete var set.
#############################################

in_default_vars_but_not_in_readme=()
for item1 in "${matches_in_default_vars[@]}"; do
    for item2 in "${matches_in_readme[@]}"; do
        [[ ${item1^^} == "${item2^^}" ]] && continue 2
    done

    # If we reached here, nothing matched.
    in_default_vars_but_not_in_readme+=( "$item1" )
done

in_readme_but_not_in_default_vars=()
for item1 in "${matches_in_readme[@]}"; do
    for item2 in "${matches_in_default_vars[@]}"; do
        [[ ${item1^^} == "${item2^^}" ]] && continue 2
    done

    # If we reached here, nothing matched.
    in_readme_but_not_in_default_vars+=( "$item1" )
done


if [ "${verbose}" = true ];
then
    printf "\n\n##### SUMMARY ###\n"
    echo "----- In DOCS (all) #${#matches_in_docs[@]} ---"
    echo ${matches_in_docs[@]}
    echo "----- In README (all) #${#matches_in_readme[@]} ---"
    echo ${matches_in_readme[@]}
    echo "----- In README (conf only) #${#matches_in_readme_conf_only[@]} ---"
    echo ${matches_in_readme_conf_only[@]}
    echo "----- In VARS (all) #${#matches_in_vars[@]} ---"
    echo ${matches_in_vars[@]}
    echo "----- In VARS (defaults only) #${#matches_in_default_vars[@]} ---"
    echo ${matches_in_default_vars[@]}
    echo "----- In VARS (conf only) #${#matches_in_vars_conf_only[@]} ---"
    echo ${matches_in_vars_conf_only[@]}
fi
printf "\n\n##### DOCS <-> README ###\n"
echo "***** Matchcounts ***"
echo "  Matches in DOCS:                                    ${#matches_in_docs[@]}"
echo "  Matches in README (conf only):                      ${#matches_in_readme_conf_only[@]}"
echo "  Matches in DOCS but not in README:                  ${#in_docs_but_not_in_readme[@]}"
echo "  Matches in README but not in DOCS:                  ${#in_readme_but_not_in_docs[@]}"
echo "  Matches in VARS (default) but not in README:        ${#in_default_vars_but_not_in_readme[@]}"
echo "  Matches in README but not in VARS (default):        ${#in_readme_but_not_in_default_vars[@]}"
echo "----- In DOCS but not in README: ---"
echo "${in_docs_but_not_in_readme[@]}"
echo "----- In README but not in DOCS: ---"
echo "${in_readme_but_not_in_docs[@]}"
echo "----- In VARS (default) but not in README: ---"
echo "${in_default_vars_but_not_in_readme[@]}"
echo "----- In README but not in VARS (default): ---"
echo "${in_readme_but_not_in_default_vars[@]}"