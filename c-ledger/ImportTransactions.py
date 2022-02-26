import csv


class Reader:
    '''
    Read a CSV from my bank for importing data into Ledger
    '''

    def __init__(self, filename):
        '''
        Attributes:
        csv_file: the filename to be parsed
        data: list of dictionaries. Each item is a dict of a row.
            Each key is the row title from line 1 of the file.
        '''
        self.csv_file = filename
        self.data = []
        self.fieldnames = []
        self.read()

    def __str__(self):
        st = ''
        for field in self.fieldnames:
            st += (str(field) + '\t')
        st += '\n'
        for row in self.data:
            for entry in row:
                st += (row[entry] + '\t')
            st += '\n'
        return st

    def read(self):
        '''
        Read self.csv_file using CSV module's DictReader class.

        Note that we are including a side-effect: calling set_fieldnames.
        This is due to the fact that CSV automatically sets reader.fieldnames
        after first read of the file.
        '''
        with open(f'{self.csv_file}', newline='') as csvfile:
            reader = csv.DictReader(csvfile)
            for row in reader:
                self.data.append(row)
            self.set_fieldnames(reader.fieldnames)

    def set_fieldnames(self, fieldnames):
        # TODO: Add check for fieldnames = None
        self.fieldnames = fieldnames


if __name__ == '__main__':
    # fn = input('Give me a filename: ')
    fn = 'CheckingActivity.csv'
    R = Reader(fn)
    print(R)
