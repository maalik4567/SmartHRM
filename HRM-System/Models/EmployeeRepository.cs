using Dapper;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web.Mvc;

namespace HRM_System.Models
{
    public class EmployeeRepository
    {
        private static readonly string strConnectionString = "Server=(localdb)\\MSSQLLocalDB;Database=HRSystem;Trusted_Connection=True;Integrated Security=SSPI;";

        public static IEnumerable<SelectListItem> GetDepartments()
        {
            using (var connection = new SqlConnection(strConnectionString))
            {
                var departments = connection.Query("SELECT Id, Name FROM Department");
                return departments.Select(d => new SelectListItem
                {
                    Value = d.Id.ToString(),
                    Text = d.Name
                });
            }
        }

        public static IEnumerable<SelectListItem> GetPositions()
        {
            using (var connection = new SqlConnection(strConnectionString))
            {
                var positions = connection.Query("SELECT Id, Title FROM Position");
                return positions.Select(p => new SelectListItem
                {
                    Value = p.Id.ToString(),
                    Text = p.Title
                });
            }
        }

        public static IEnumerable<SelectListItem> GetEmployeeTypes()
        {
            using (var connection = new SqlConnection(strConnectionString))
            {
                var employeeTypes = connection.Query("SELECT Id, Type FROM EmployeeType");
                return employeeTypes.Select(et => new SelectListItem
                {
                    Value = et.Id.ToString(),
                    Text = et.Type
                });
            }
        }

        //GET LIST OF EMPLOYEES
        public static IEnumerable<Employee> GetAllEmployees()
        {
            using (var connection = new SqlConnection(strConnectionString))
            {
                return connection.Query<Employee>("GetAllEmployees", commandType: System.Data.CommandType.StoredProcedure);
            }
        }

        //BY ID 
        public static Employee GetEmployeeById(int empId)
        {
            using (var connection = new SqlConnection(strConnectionString))
            {
                return connection.QuerySingleOrDefault<Employee>(
                    "GetEmployeeById",
                    new { EmpId = empId },
                    commandType: System.Data.CommandType.StoredProcedure);
            }
        }


        public static int InsertEmployee(Employee employee)
        {
            using (var connection = new SqlConnection(strConnectionString))
            {
                var query = "InsertEmployee"; // Stored procedure name

                var parameters = new
                {
                    FullName = employee.FullName,
                    Email = employee.Email,
                    Department = employee.Department,
                    Position = employee.Position,
                    HireDate = employee.HireDate,
                    DateOfBirth = employee.DateOfBirth,
                    EmployeeType = employee.EmployeeType,
                    Gender = employee.Gender,
                    Salary = employee.Salary,
                    CNIC = employee.CNIC,
                    PhoneNumber = employee.PhoneNumber
                };

                var empId = connection.QuerySingle<int>("InsertEmployee", parameters, commandType: System.Data.CommandType.StoredProcedure);
                return empId;
            }
        }

    }
}
