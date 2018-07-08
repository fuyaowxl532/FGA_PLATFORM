using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.OleDb;

namespace FGA_NUtility
{
    //Plex webservices相关方法
    public class PlexHelper
    {
        public static FGA_NUtility.POL.Service getPlexServer()
        {
            FGA_NUtility.POL.Service service = new FGA_NUtility.POL.Service();
            System.Net.NetworkCredential credential = new System.Net.NetworkCredential("FuyaoDaytonWs@plex.com", "6deb1ee-e9b");
            System.Net.CredentialCache credentialCache = new System.Net.CredentialCache();
            service.Url = "https://testapi.plexonline.com/DataSource/Service.asmx";
            credentialCache.Add(new Uri(service.Url), "BASIC", credential);
            service.Credentials = credentialCache;

            return service;
        }

        public static FGA_NUtility.POL.ExecuteDataSourceResult PlexGetResult_0(String datasource_key, String datasource_name)
        {

            FGA_NUtility.POL.ExecuteDataSourceRequest request = new FGA_NUtility.POL.ExecuteDataSourceRequest();
            request.DataSourceKey = datasource_key;
            request.DataSourceName = datasource_name;

            return getPlexServer().ExecuteDataSource(request);
        }

        public static FGA_NUtility.POL.ExecuteDataSourceResult PlexGetResult_1(String datasource_key, String datasource_name,
            String paraname1, String para1)
        {

            FGA_NUtility.POL.ExecuteDataSourceRequest request = new FGA_NUtility.POL.ExecuteDataSourceRequest();
            request.DataSourceKey = datasource_key;
            request.DataSourceName = datasource_name;
            request.InputParameters = new FGA_NUtility.POL.InputParameter[1];
            request.InputParameters[0] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[0].Name = paraname1;
            request.InputParameters[0].Value = para1;

            return getPlexServer().ExecuteDataSource(request);
        }

        public static FGA_NUtility.POL.ExecuteDataSourceResult PlexGetResult_2(String datasource_key, String datasource_name,
            String paraname1, String paraname2, String para1, String para2)
        {
            FGA_NUtility.POL.ExecuteDataSourceRequest request = new FGA_NUtility.POL.ExecuteDataSourceRequest();
            request.DataSourceKey = datasource_key;
            request.DataSourceName = datasource_name;
            request.InputParameters = new FGA_NUtility.POL.InputParameter[2];
            request.InputParameters[0] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[0].Name = paraname1;
            request.InputParameters[0].Value = para1;
            request.InputParameters[1] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[1].Name = paraname2;
            request.InputParameters[1].Value = para2;

            return getPlexServer().ExecuteDataSource(request);
        }

        public static FGA_NUtility.POL.ExecuteDataSourceResult PlexGetResult_3(String datasource_key, String datasource_name,
            String paraname1, String paraname2, String paraname3, String para1, String para2, String para3)
        {
            FGA_NUtility.POL.ExecuteDataSourceRequest request = new FGA_NUtility.POL.ExecuteDataSourceRequest();
            request.DataSourceKey = datasource_key;
            request.DataSourceName = datasource_name;
            request.InputParameters = new FGA_NUtility.POL.InputParameter[3];
            request.InputParameters[0] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[0].Name = paraname1;
            request.InputParameters[0].Value = para1;
            request.InputParameters[1] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[1].Name = paraname2;
            request.InputParameters[1].Value = para2;
            request.InputParameters[2] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[2].Name = paraname3;
            request.InputParameters[2].Value = para3;

            return getPlexServer().ExecuteDataSource(request);
        }

        public static FGA_NUtility.POL.ExecuteDataSourceResult PlexGetResult_4(String datasource_key, String datasource_name,
            String paraname1, String paraname2, String paraname3, String paraname4, String para1, String para2, String para3, String para4)
        {
            FGA_NUtility.POL.ExecuteDataSourceRequest request = new FGA_NUtility.POL.ExecuteDataSourceRequest();
            request.DataSourceKey = datasource_key;
            request.DataSourceName = datasource_name;
            request.InputParameters = new FGA_NUtility.POL.InputParameter[4];
            request.InputParameters[0] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[0].Name = paraname1;
            request.InputParameters[0].Value = para1;
            request.InputParameters[1] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[1].Name = paraname2;
            request.InputParameters[1].Value = para2;
            request.InputParameters[2] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[2].Name = paraname3;
            request.InputParameters[2].Value = para3;
            request.InputParameters[3] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[3].Name = paraname4;
            request.InputParameters[3].Value = para4;

            return getPlexServer().ExecuteDataSource(request);
        }

        public static FGA_NUtility.POL.ExecuteDataSourceResult PlexGetResult_5(String datasource_key, String datasource_name,
          String paraname1, String paraname2, String paraname3, String paraname4, String paraname5, String para1, String para2, String para3, String para4, String para5)
        {
            FGA_NUtility.POL.ExecuteDataSourceRequest request = new FGA_NUtility.POL.ExecuteDataSourceRequest();
            request.DataSourceKey = datasource_key;
            request.DataSourceName = datasource_name;
            request.InputParameters = new FGA_NUtility.POL.InputParameter[5];
            request.InputParameters[0] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[0].Name = paraname1;
            request.InputParameters[0].Value = para1;
            request.InputParameters[1] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[1].Name = paraname2;
            request.InputParameters[1].Value = para2;
            request.InputParameters[2] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[2].Name = paraname3;
            request.InputParameters[2].Value = para3;
            request.InputParameters[3] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[3].Name = paraname4;
            request.InputParameters[3].Value = para4;
            request.InputParameters[4] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[4].Name = paraname5;
            request.InputParameters[4].Value = para5;

            return getPlexServer().ExecuteDataSource(request);
        }


        public static FGA_NUtility.POL.ExecuteDataSourceResult PlexGetResult_6(String datasource_key, String datasource_name,
          String paraname1, String paraname2, String paraname3, String paraname4, String paraname5, String paraname6, String para1, String para2, String para3, String para4, String para5, String para6)
        {
            FGA_NUtility.POL.ExecuteDataSourceRequest request = new FGA_NUtility.POL.ExecuteDataSourceRequest();
            request.DataSourceKey = datasource_key;
            request.DataSourceName = datasource_name;
            request.InputParameters = new FGA_NUtility.POL.InputParameter[6];
            request.InputParameters[0] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[0].Name = paraname1;
            request.InputParameters[0].Value = para1;
            request.InputParameters[1] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[1].Name = paraname2;
            request.InputParameters[1].Value = para2;
            request.InputParameters[2] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[2].Name = paraname3;
            request.InputParameters[2].Value = para3;
            request.InputParameters[3] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[3].Name = paraname4;
            request.InputParameters[3].Value = para4;
            request.InputParameters[4] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[4].Name = paraname5;
            request.InputParameters[4].Value = para5;

            request.InputParameters[5] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[5].Name = paraname6;
            request.InputParameters[5].Value = para6;

            return getPlexServer().ExecuteDataSource(request);
        }


        public static FGA_NUtility.POL.ExecuteDataSourceResult PlexGetResult_7(String datasource_key, String datasource_name,
          String paraname1, String paraname2, String paraname3, String paraname4, String paraname5, String paraname6, String paraname7, String para1, String para2, String para3, String para4, String para5, String para6, String para7)
        {
            FGA_NUtility.POL.ExecuteDataSourceRequest request = new FGA_NUtility.POL.ExecuteDataSourceRequest();
            request.DataSourceKey = datasource_key;
            request.DataSourceName = datasource_name;
            request.InputParameters = new FGA_NUtility.POL.InputParameter[7];
            request.InputParameters[0] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[0].Name = paraname1;
            request.InputParameters[0].Value = para1;
            request.InputParameters[1] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[1].Name = paraname2;
            request.InputParameters[1].Value = para2;
            request.InputParameters[2] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[2].Name = paraname3;
            request.InputParameters[2].Value = para3;
            request.InputParameters[3] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[3].Name = paraname4;
            request.InputParameters[3].Value = para4;
            request.InputParameters[4] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[4].Name = paraname5;
            request.InputParameters[4].Value = para5;

            request.InputParameters[5] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[5].Name = paraname6;
            request.InputParameters[5].Value = para6;
            request.InputParameters[6] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[6].Name = paraname7;
            request.InputParameters[6].Value = para7;

            return getPlexServer().ExecuteDataSource(request);
        }

        public static FGA_NUtility.POL.ExecuteDataSourceResult PlexGetResult_10(String datasource_key, String datasource_name,
          String paraname1, String paraname2, String paraname3, String paraname4, String paraname5, String paraname6, String paraname7, String paraname8, String paraname9, String paraname10,
            String para1, String para2, String para3, String para4, String para5, String para6, String para7, String para8, String para9, String para10)
        {
            FGA_NUtility.POL.ExecuteDataSourceRequest request = new FGA_NUtility.POL.ExecuteDataSourceRequest();
            request.DataSourceKey = datasource_key;
            request.DataSourceName = datasource_name;
            request.InputParameters = new FGA_NUtility.POL.InputParameter[10];
            request.InputParameters[0] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[0].Name = paraname1;
            request.InputParameters[0].Value = para1;
            request.InputParameters[1] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[1].Name = paraname2;
            request.InputParameters[1].Value = para2;
            request.InputParameters[2] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[2].Name = paraname3;
            request.InputParameters[2].Value = para3;
            request.InputParameters[3] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[3].Name = paraname4;
            request.InputParameters[3].Value = para4;
            request.InputParameters[4] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[4].Name = paraname5;
            request.InputParameters[4].Value = para5;

            request.InputParameters[5] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[5].Name = paraname6;
            request.InputParameters[5].Value = para6;
            request.InputParameters[6] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[6].Name = paraname7;
            request.InputParameters[6].Value = para7;
            request.InputParameters[7] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[7].Name = paraname8;
            request.InputParameters[7].Value = para8;
            request.InputParameters[8] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[8].Name = paraname9;
            request.InputParameters[8].Value = para9;
            request.InputParameters[9] = new FGA_NUtility.POL.InputParameter();
            request.InputParameters[9].Name = paraname10;
            request.InputParameters[9].Value = para10;

            return getPlexServer().ExecuteDataSource(request);
        }
    }
}
