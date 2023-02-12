from list_comparer import *
from var_collector import *

#############################################
# DOCS vs README
# - What:   Do not miss a new feature or deprecated variable
# - How:    Compare DOCS complete var set with roles README conf vars that correspond with DOCS.
#############################################
def readme_vs_docs():
    # Get vars to compare in a format without prefix
    vars_docs_all = get_pngx_docs_configuration_vars(r'\`(?:PAPERLESS_)?(.*?)=<.*>\`')
    vars_readme_conf = get_role_readme_configuration_vars(r'\|\s*\`paperless_ngx_conf_(.*?)\`\s*\|')
    in_docs_but_not_in_readme = ['PAPERLESS_' + item for item in in_a_but_not_in_b(vars_docs_all, vars_readme_conf, False)]
    in_readme_but_not_in_docs = ['paperless_ngx_conf_' + item for item in in_a_but_not_in_b(vars_readme_conf, vars_docs_all, False)]
    print_scenario_result("DOCS", vars_docs_all, "README", vars_readme_conf, in_docs_but_not_in_readme, in_readme_but_not_in_docs)


def print_scenario_result(a_name: str, a: list, b_name: str, b: list, result1: list, result2: list):
    titles = ['name', 'count']
    names = ["Matches in " + a_name, "Matches in " + b_name, "In " + a_name + " but not in " + b_name, "in " + b_name + " but not in " + a_name]
    matchcount = [len(a), len(b), len(result1), len(result2)]

    data = [titles] + list(zip(names, matchcount))
    
    print ("##### " + a_name + " <-> " + b_name + " ###")
    
    # https://stackoverflow.com/a/39032993/5968749
    for i, d in enumerate(data):
        line = '|'.join(str(x).ljust(50) for x in d)
        print(line)
        if i == 0:
            print('-' * len(line))