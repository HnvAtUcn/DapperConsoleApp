using System;
using System.Configuration;
using System.Data.SqlClient;
using Dapper;

namespace DapperConsoleApp
{
    class Program
    {
        // Internal class for holding selects from Book INNER JOIN Language
        class Result
        {
            public string? Title { get; set; }
            public double? Price { get; set; }
            public string? Name { get; set; }
        }

        static void Main(string[] args)
        {
            string conn = ConfigurationManager.ConnectionStrings["DapperConnStr"].ConnectionString;

            // Example query strings used below
            string sql1 = "SELECT Title, Description FROM Book";
            string sql1A = "SELECT Title, Description, Cover FROM Book";
            string sql2A = "SELECT * FROM Book INNER JOIN Language ON Book.LanguageId = Language.LanguageId";
            string sql2B = "SELECT Book.Title, Book.Price, Book.LanguageId, Language.Name FROM Book INNER JOIN Language ON Book.LanguageId = Language.LanguageId";
            string sql3 = "SELECT * FROM ViewExample";
            string sql4 = "UPDATE ViewExample SET Price = @Price WHERE(Name = @Name)";
            string sql5 = "SELECT COUNT(*) FROM BookGenre";


            using (SqlConnection connection = new SqlConnection(conn))
            {
                // Simple query: "SELECT Title, Description FROM Book"
                var books = connection.Query<Book>(sql1).ToList();

                // Print out the expected Title and Description
                Console.WriteLine("Titles and descriptions:");
                foreach (var title_desc in books)
                {
                    Console.WriteLine(title_desc.Title + ", " + title_desc.Description);
                }
                Console.WriteLine();

                /**********************************************************************************************************************************/

                // Try to print out the expected Title and Description + Cover which is a property  of the Book class.
                // What happens? Exception? Error? Debug and inspect the title_desc var
                //books = connection.Query<Book>(sql1A).ToList();

                Console.WriteLine("Titles, descriptions and cover:");
                foreach (var title_desc in books)
                {
                    Console.WriteLine(title_desc.Title + ", " + title_desc.Description + ", " + title_desc.Cover);
                }
                Console.WriteLine();

                /**********************************************************************************************************************************/

                string Outputstring; // Let's format things a bit

                // Select a result from an INNER JOIN on two tables. The syntax is more complex than a single table select.
                // A third class, Result, must hold values selected from the two tables. The selection is specified in the lambda below
                // Query string (sql2A): SELECT * FROM Book INNER JOIN Language ON Book.LanguageID = Language.LanguageID
                var result = connection.Query<Book, Language, Result>(sql2A,
                    (b, l) =>
                    {
                        Result res = new Result();
                        b.LanguageId = l.LanguageId;
                        res.Price = b.Price;
                        res.Title = b.Title;
                        res.Name = l.Name;

                        return res;
                    },

                    splitOn: "LanguageId");

                foreach (var res in result)
                {
                    Outputstring = $"Title: {res.Title,-27} | Price: {res.Price,-7} | Name: {res.Name,-28}";
                    Console.WriteLine(Outputstring);
                }
                Console.WriteLine();

                /**********************************************************************************************************************************/

                // Make the query more effective and faster by only selecting columns that are needed in the app (don't use SELECT *)
                // Query string (sql2B): SELECT Book.Title, Book.Price, Book.LanguageID, Language.Name  FROM Book INNER JOIN Language ON Book.LanguageID = Language.LanguageID
                result = connection.Query<Book, Language, Result>(sql2B,
                    (b, l) =>
                    {
                        Result res = new Result();
                        b.LanguageId = l.LanguageId;
                        res.Price = b.Price;
                        res.Title = b.Title;
                        res.Name = l.Name;

                        return res;
                    },

                    splitOn: "LanguageId");

                foreach (var res in result)
                {
                    Outputstring = $"Title: {res.Title,-27} | Price: {res.Price,-7} | Name: {res.Name,-28}";
                    Console.WriteLine(Outputstring);
                }
                Console.WriteLine();

                /**********************************************************************************************************************************/

                // The selection from the INNER JOIN on two tables can be done with a simpler syntax, as long as the <Result> class can hold the result.
                result = connection.Query<Result>(sql2B);
                foreach (var res in result)
                {
                    Outputstring = $"Title: {res.Title,-27} | Price: {res.Price,-7} | Name: {res.Name,-28}";
                    Console.WriteLine(Outputstring);
                }
                Console.WriteLine();

                /**********************************************************************************************************************************/

                // If the view named ViewExample is defined, we can select from it: SELECT * FROM ViewExample";
                result = connection.Query<Result>(sql3);
                foreach (var res in result)
                {
                    Outputstring = $"Title: {res.Title,-27} | Price: {res.Price,-7} | Name: {res.Name,-28}";
                    Console.WriteLine(Outputstring);
                }
                Console.WriteLine();

                /**********************************************************************************************************************************/

                // It is possible to use views as tables in some circumstances: Update the Book.Price column throught the View 
                var affectedRows = connection.Execute(sql4, new { Name = "Danish", Price = 600 });
                Console.WriteLine("Affected Rows: " + affectedRows);

                result = connection.Query<Result>(sql3);
                foreach (var res in result)
                {
                    Outputstring = $"Title: {res.Title,-27} | Price: {res.Price,-7} | Name: {res.Name,-28}";
                    Console.WriteLine(Outputstring);
                }
                Console.WriteLine();

                /**********************************************************************************************************************************/

                // Possible to query aggregates
                int count = (int)connection.ExecuteScalar(sql5);
                Console.WriteLine("There are " + count + " rows in the BookGenre table ");

                Console.ReadLine();

            }
        }
    }
}
