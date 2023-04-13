using System;
using System.Configuration;
using System.Data.SqlClient;
using Dapper;

namespace DapperConsoleApp
{
    class Program
    {
        // Internal class for holding selects from the Language table
        internal class Language
        {
            public int LanguageId { get; set; }
            public string LangCode { get; set; } = "";
        }

        // Internal class for holding selects from Book INNER JOIN Language
        internal class Result
        {
            public string Title { get; set; } = "";
            public double? Price { get; set; }
            public string LangCode { get; set; } = "";
        }

        static void Main(string[] args)
        {
            string conn = ConfigurationManager.ConnectionStrings["DapperConnStr"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(conn))
            {
             //Example 1 **************************************************************************************************************************/
                // Simple query: "SELECT Title, Description FROM Book"
                string sql1A = "SELECT Title, Description FROM Book";
                var books = connection.Query<Book>(sql1A).ToList();

                // Print out the expected Title and Description
                Console.WriteLine("Titles and descriptions:");
                foreach (var title_desc in books)
                {
                    Console.WriteLine(title_desc.Title + ", " + title_desc.Description);
                }
                Console.WriteLine();

                /**********************************************************************************************************************************/

             //Example 2 **************************************************************************************************************************/
                // Try to print out the expected Title and Description + CoverImage which is NOT a column of the Book class.
                // What happens? Exception? Error? Debug and inspect the title_desc var
                //string sql1B = "SELECT Title, Description, CoverImage FROM Book";
                //books = connection.Query<Book>(sql1B).ToList();

                //Console.WriteLine("Titles, descriptions and cover:");
                //foreach (var title_desc in books)
                //{
                //    Console.WriteLine(title_desc.Title + ", " + title_desc.Description + ", " + title_desc.Cover);
                //}
                //Console.WriteLine();

                /**********************************************************************************************************************************/

             //Example 3 **************************************************************************************************************************/
                string Outputstring; // Let's format things a bit

                // Select a result from an INNER JOIN on two tables. The syntax is more complex than a single table select.
                // A third class, Result, must hold values selected from the two tables. The selection is specified in the lambda below
                string sql2A = "SELECT * FROM Book INNER JOIN Language ON Book.LanguageId = Language.LanguageId";
                var result = connection.Query<Book, Language, Result>(sql2A,
                    (b, l) =>
                    {
                        Result res = new Result();
                        b.LanguageId = l.LanguageId;
                        res.Price = b.Price;
                        res.Title = b.Title;
                        res.LangCode = l.LangCode;

                        return res;
                    },

                    splitOn: "LanguageId");

                foreach (var res in result)
                {
                    Outputstring = $"Title: {res.Title,-27} | Price: {res.Price,-7} | LangCode: {res.LangCode,-28}";
                    Console.WriteLine(Outputstring);
                }
                Console.WriteLine();

                /**********************************************************************************************************************************/

             //Example 4 **************************************************************************************************************************/
                // Make the query more effective and faster by only selecting columns that are needed in the app (don't use SELECT *)
                string sql2B = "SELECT Book.Title, Book.Price, Book.LanguageId, Language.LangCode FROM Book INNER JOIN Language ON Book.LanguageId = Language.LanguageId";
                result = connection.Query<Book, Language, Result>(sql2B,
                    (b, l) =>
                    {
                        Result res = new Result();
                        b.LanguageId = l.LanguageId;
                        res.Price = b.Price;
                        res.Title = b.Title;
                        res.LangCode = l.LangCode;

                        return res;
                    },

                    splitOn: "LanguageId");

                foreach (var res in result)
                {
                    Outputstring = $"Title: {res.Title,-27} | Price: {res.Price,-7} | LangCode: {res.LangCode,-28}";
                    Console.WriteLine(Outputstring);
                }
                Console.WriteLine();

                /**********************************************************************************************************************************/

             //Example 5 **************************************************************************************************************************/
                // The selection from the INNER JOIN on two tables can be done with a simpler syntax, as long as the <Result> class can hold the result.
                result = connection.Query<Result>(sql2B);
                foreach (var res in result)
                {
                    Outputstring = $"Title: {res.Title,-27} | Price: {res.Price,-7} | LangCode: {res.LangCode,-28}";
                    Console.WriteLine(Outputstring);
                }
                Console.WriteLine();

                /**********************************************************************************************************************************/

             //Example 6 **************************************************************************************************************************/
                // If the view named ViewExample is defined, we can select from it: SELECT * FROM ViewExample";
                string sql3A = "SELECT * FROM ViewExample";
                result = connection.Query<Result>(sql3A);
                foreach (var res in result)
                {
                    Outputstring = $"Title: {res.Title,-27} | Price: {res.Price,-7} | LangCode: {res.LangCode,-28}";
                    Console.WriteLine(Outputstring);
                }
                Console.WriteLine();

                /**********************************************************************************************************************************/

             //Example 7 **************************************************************************************************************************/
                // It is possible to use views as tables in some circumstances: Update the Book.Price column through the View 
                // First, read current prices from the view where Language is Danish (we will write them back in a moment!)
                string sql4A = "SELECT * FROM ViewExample WHERE(LangCode = @LangCode)";
                var readResult = connection.Query<Result>(sql4A, new { LangCode = "Danish"});

                // Next, update all Danish books with a silly price...
                string sql4B = "UPDATE ViewExample SET Price = @Price WHERE(LangCode = @LangCode)";
                var affectedRows = connection.Execute(sql4B, new { LangCode = "Danish", Price = 600 });
                Console.WriteLine("Affected Rows: " + affectedRows);

                result = connection.Query<Result>(sql3A); // Reusing this query string!
                foreach (var res in result)
                {
                    Outputstring = $"Title: {res.Title,-27} | Price: {res.Price,-7} | LangCode: {res.LangCode,-28}";
                    Console.WriteLine(Outputstring);
                }
                Console.WriteLine();

                // Finally, restore the natural prices defined by normal market mechanisms!
                foreach (var res in readResult)
                {
                    string sql4C = "UPDATE ViewExample SET Price = @Price WHERE Title = @Title";
                    connection.Execute(sql4C, new { res.Title, res.Price });
                }
                Console.WriteLine();

                /**********************************************************************************************************************************/

             //Example 8 **************************************************************************************************************************/
                // Possible to query aggregates and return them as scalars
                string sql5A = "SELECT COUNT(*) FROM BookGenre";
                int count = (int)connection.ExecuteScalar(sql5A);
                Console.WriteLine("There are " + count + " rows in the BookGenre table ");

                Console.ReadLine();

            }
        }
    }
}
