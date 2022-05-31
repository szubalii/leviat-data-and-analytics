import os
from pathlib import Path
import csv
import re

class file_paths(Exception):
    MASTER_DATA_ROOT = 'Master Data'
    SCRIPT_ROOT = 'syndw_xxxx_sls_d_euw_001'
    MASTER_DATA_CONFIG = 'master-data-config.csv'

def get_table_pk_from_sql_file(source_path):
    """
    get_table_pk_from_sql_file returns primary key columns from sql script

    :param source_path: path to sql script
    :return: list of primary key columns
    """
    with open(source_path, mode='r') as infile:
        data = infile.read()
        data = data.replace('\n', ' ').replace('\r', '')
        data = re.sub('[\s]+', '', data)
        result = re.search(r'(PRIMARYKEYNONCLUSTERED\((.*)\)NOTENFORCED)', data)

        if result:
            result = result.group(0).replace('PRIMARYKEYNONCLUSTERED(', '') \
                .replace(')NOTENFORCED', '') \
                .replace('[', '') \
                .replace(']', '')
            return  result.split(',')

def check_file_for_duplicates(file_path, delimiter, table_pk):
    """
    check_file_for_duplicates checks for duplicates relative to primary key columns

    :param file_path: path to csv file
    :param delimiter: delimiter in csv file
    :param table_pk: list of primary key columns
    """
    column_num = list()
    print('Cheking file "{0}" for duplicates'.format(file_path))
    with open(file_path, mode='r', encoding='utf-8-sig') as infile:
        reader = csv.reader(infile, delimiter=delimiter, quoting=csv.QUOTE_MINIMAL)
        headers = next(reader)
        dupes = []
        non_repeating_set = set()
        if table_pk:
            for column in table_pk:
                if column in headers:
                    column_num.append(headers.index(column))
                else:
                    raise Exception('File "{0}" not contains column: {1}\n header: {2}'.format(file_path, column, headers))
            for row in reader:
                primery_keys = [e for i, e in enumerate(row) if i in column_num]
                str_primery_keys = ', '.join(primery_keys)
                if str_primery_keys in non_repeating_set:
                    dupes.extend([primery_keys])
                else:
                    non_repeating_set.add(str_primery_keys)
        else:
            for rows in reader:
                str = ''.join(rows)
                if str in non_repeating_set:
                    dupes.extend([rows])
                else:
                    non_repeating_set.add(str)
        if dupes:
            raise Exception('File "{0}" contains duplicates: {1}'.format(file_path, dupes))


def process_master_data(file_path, file_name):
    """
    process_master_data reading data from master data file
    and checking data for duplicates

    :param file_path: path to master data file
    :param file_name: file name of master data
    """
    with open(os.path.join(file_path, file_name), mode='r', encoding='utf8') as infile:
        reader = csv.reader(infile, delimiter=";")
        headers = next(reader)
        for row in reader:
            master_data_script_path = os.path.join(file_paths.SCRIPT_ROOT, row[3], 'Tables', row[4]+'.sql')
            master_data_file_path = os.path.join(file_paths.SCRIPT_ROOT, file_paths.MASTER_DATA_ROOT, row[0], row[1])
            master_data_delimiter = row[2]
            table_pk = get_table_pk_from_sql_file(master_data_script_path)
            check_file_for_duplicates(master_data_file_path, master_data_delimiter, table_pk)

print("START CHECKING FILES FOR DUPLICATES")

source_path = os.path.join(file_paths.SCRIPT_ROOT, file_paths.MASTER_DATA_ROOT)
process_master_data(source_path, file_paths.MASTER_DATA_CONFIG)

print("FINISH")