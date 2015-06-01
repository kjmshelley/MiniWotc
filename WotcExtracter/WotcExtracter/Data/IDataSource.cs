using System;
using System.Data;
using System.Collections.Generic;

namespace WotcExtracter.Data
{
    /// <summary>
    /// This interface is to serve for all Datasources.
    /// A datasource can be anything, flat file, stored procedure, excel file, etc.
    /// However, every datasource MUST return a datatable. 
    /// The reason for this design is to make it easy to transform the data before output.
    /// For example, if you want to create a class to access a database,
    /// you can create a class that implements this interface and returns a data table.
    /// The same goes for an excel file or flat file. 
    /// </summary>
    public interface IDataSource
    {
        DataTable Read(string source);
        void Write(string value);
        void Write(List<string> values);
        bool Open(string datasourceLocation);
        bool Close();
    }
}
