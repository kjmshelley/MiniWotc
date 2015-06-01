using System;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace WotcExtracter.Data
{
    public enum DataCommandType
    {
        StoredProcedure,
        SQLStatement
    }

    /// <summary>
    /// For this DB datasource we are just going to assume the DB is talking 
    /// to a sql server. However, you are not limited to just this DB.
    /// </summary>
    public class DBDataSource : IDataSource
    {
        private SqlConnection conn;
        private SqlCommand comm;
        private SqlDataAdapter adapter;
        private CommandType ct;

        public DBDataSource() { }
        public DBDataSource(DataCommandType dct)
        {
            if (dct == DataCommandType.SQLStatement)
                ct = CommandType.Text;
            else
                ct = CommandType.StoredProcedure;
        }

        public DBDataSource(string connectionString, DataCommandType dct)
        {
            if (dct == DataCommandType.SQLStatement)
                ct = CommandType.Text;
            else
                ct = CommandType.StoredProcedure;

            Open(connectionString);
        }

        public void AddParameter(string name, string value)
        {
            comm.Parameters.AddWithValue(name, value);
        }

        public void ResetParameters()
        {
            comm.Parameters.Clear();
        }

        public DataTable Read(string source)
        {
            //Open(string.Empty);
            DataTable table = new DataTable();
            comm.CommandType = CommandType.StoredProcedure;
            comm.CommandText = source;
            adapter.Fill(table);
            return table;
        }

        /* We will not implement this for this example */
        public void Write(string value)
        {
            throw new NotImplementedException();
        }

        /* We will not implement this for this example */
        public void Write(List<string> values)
        {
            throw new NotImplementedException();
        }

        public bool Open(string datasourceLocation)
        {
            try
            {
                if (conn == null || conn.State == ConnectionState.Closed)
                {
                    conn = new SqlConnection(datasourceLocation);
                    comm = new SqlCommand() { CommandType = ct, Connection = conn };
                    adapter = new SqlDataAdapter(comm);
                    conn.Open();
                }
            }
            finally { }
            return true;
        }

        public bool Close()
        {
            if (conn == null || conn.State != ConnectionState.Closed)
                conn.Close();

            return true;
        }
    }
}
