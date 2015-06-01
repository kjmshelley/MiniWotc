using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.IO;

namespace WotcExtracter.Data
{
    public class FileDataSource : IDataSource
    {
        FileInfo fi = null;
        public FileDataSource() { }
        public FileDataSource(string fileName)
        {
            Open(fileName);
        }

        /* we will not implement this method for this example */
        public DataTable Read(string source)
        {
            throw new NotImplementedException();
        }

        public void Write(string value)
        {
            try
            {
                StreamWriter sw = new StreamWriter(fi.FullName);
                sw.Write(value);
                sw.Close();
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        public void Write(List<string> values)
        {
            throw new NotImplementedException();
        }

        public bool Open(string datasourceLocation)
        {
            fi = new FileInfo(datasourceLocation);
            return true;
        }

        public bool Close()
        {
            throw new NotImplementedException();
        }
    }
}
