import numpy as np
from pandas import DataFrame, read_csv
from collections import OrderedDict
import sys
import time

def multi_split(x):
    bad_num = ['-99900.0', '-99901.0', '-99903.0', '999.0', 'nan']
    f = lambda s: float(s) if s not in bad_num else np.nan
    return map(f, x)

def flatten_data(data_loc):
    df = read_csv(data_loc)
    parse_col = df.columns.drop(['Id', 'Expected'])
    new_df = DataFrame(columns=df.columns)
    count = 0
    for index, row in df.iterrows():
        if count % 100 == 0:
            print count
        num_id_elements = len(row[1].split(' '))
        # matrix = np.zeros((num_id_elements, num_id_elements))

        for i in range(num_id_elements):
            current_list = []
            current_list.append(('Id', [row['Id'] for _ in xrange(num_id_elements)]))
            for col in parse_col:
                # print row[col]
                if type(row[col]) != str:
                    current_list.append((col, row[col]))
                else:
                    current_list.append((col, multi_split(row[col].split(' '))))
            current_list.append(('Expected', [row['Expected'] for _ in xrange(num_id_elements)]))
            new_df = new_df.append(DataFrame(OrderedDict(current_list)), ignore_index=True)

        count += 1
    return new_df

if __name__ == '__main__':
    start = time.time()
    dataloc = sys.argv[1]
    output = sys.argv[2]

    new_data = flatten_data(dataloc)
    new_data.to_csv(output, index=False)
    print("--- %f seconds ---" % (time.time() - start))
