using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace WotcExtracter.Data
{
    public class ExcelDataSource : IDataSource
    {
        public DataTable Read(string source)
        {
            throw new NotImplementedException();
        }

        public void Write(string value)
        {
            throw new NotImplementedException();
        }

        public void Write(List<string> values)
        {
            throw new NotImplementedException();
        }

        public bool Open(string datasourceLocation)
        {
            throw new NotImplementedException();
        }

        public bool Close()
        {
            throw new NotImplementedException();
        }
    }
}
