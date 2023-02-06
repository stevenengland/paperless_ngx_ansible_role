#!/bin/bash

while getopts d:v flag
do
    case "${flag}" in
        d) diff_scenario=${OPTARG};;
        v) verbose=true;;
    esac
done

echo "$verbose"

dir=$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)

config_docs_html_body=$(curl -sb -L -H "Accept: text/plain; charset=utf-8" "https://raw.githubusercontent.com/paperless-ngx/paperless-ngx/main/docs/configuration.md")
config_readme_md_body=$(<$dir/../README.md)
config_default_vars_yaml_body=$(<$dir/../defaults/main.yml)

# Get vars from docs
pattern_for_docs="\`(?:PAPERLESS_)?(.*?)=<.*>\`"
matches_in_docs=( $(echo "$config_docs_html_body" | pcregrep -o1 $pattern_for_docs) )

# Get conf vars from readme
pattern_for_readme_conf_only="\`paperless_ngx_conf_(.*?)\`"
matches_in_readme_conf_only=( $(echo "$config_readme_md_body" | pcregrep -o1 $pattern_for_readme_conf_only) )

# Get all vars from readme
pattern_for_readme="\`paperless_ngx_(.*?)\`"
matches_in_readme=( $(echo "$config_readme_md_body" | pcregrep -o1 $pattern_for_readme) )

# Get conf vars from defaults file
pattern_for_default_vars_conf_only="\`paperless_ngx_conf_(.*?)\`"
matches_in_default_vars_conf_only=( $(echo "$config_default_vars_yaml_body" | pcregrep -o1 $pattern_for_default_vars_conf_only) )

# Get all vars from defaults file
pattern_for_default_vars="\`paperless_ngx_conf_(.*?)\`"
matches_in_default_vars=( $(echo "$config_default_vars_yaml_body" | pcregrep -o1 $pattern_for_default_vars) )

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

if [ "${verbose}" = true ];
then
    printf "\n\n\n##### docs <- readme ###"
    echo "***** Matchcounts ***"
    echo "  Matches in docs:                      ${#matches_in_docs[@]}"
    echo "  Matches in readme conf only:          ${#matches_in_readme_conf_only[@]}"
    echo "  Matches in docs but not in readme:    ${#in_docs_but_not_in_readme[@]}"
    echo "----- In docs ---"
    echo ${matches_in_docs[@]}
    echo "----- In readme ---"
    echo ${matches_in_readme_conf_only[@]}
fi
echo "----- In docs but not in readme: ---"
echo "${in_docs_but_not_in_readme[@]}"

if [ "${verbose}" = true ];
then
    printf "\n\n\n##### readme <- docs ###"
    echo "***** Matchcounts ***"
    echo "  Matches in docs:                      ${#matches_in_docs[@]}"
    echo "  Matches in readme conf only:          ${#matches_in_readme_conf_only[@]}"
    echo "  Matches in readme but not in docs:    ${#in_readme_but_not_in_docs[@]}"
    echo "----- In docs ---"
    echo ${matches_in_docs[@]}
    echo "----- In readme ---"
    echo ${matches_in_readme_conf_only[@]}
fi
echo "----- In docs but not in readme: ---"
echo "${in_readme_but_not_in_docs[@]}"