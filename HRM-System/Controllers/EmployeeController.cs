using HRM_System.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace HRM_System.Controllers
{
    public class EmployeeController : Controller
    {
        // GET: Employee List
        public ActionResult ListEmployee()
        {
            var employees = EmployeeRepository.GetAllEmployees();
            return View(employees);
        }

        // GET: Create Employee
        public ActionResult CreateEmployee()
        {
            ViewBag.Departments = EmployeeRepository.GetDepartments();
            ViewBag.Positions = EmployeeRepository.GetPositions();
            ViewBag.EmployeeTypes = EmployeeRepository.GetEmployeeTypes();

            return View();
        }

        [HttpPost]
        public ActionResult CreateEmployee(Employee employee)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    // Capture the returned EmpId
                    int empId = EmployeeRepository.InsertEmployee(employee);
                    return RedirectToAction("Success", new { id = empId });
                }
                catch (Exception ex)
                {
                    // Use a logging framework in a real-world application
                    Console.WriteLine("Error inserting employee: " + ex.Message);
                    ModelState.AddModelError("", "An error occurred while saving the employee.");
                }
            }

            // Reload dropdown lists
            ViewBag.Departments = EmployeeRepository.GetDepartments();
            ViewBag.Positions = EmployeeRepository.GetPositions();
            ViewBag.EmployeeTypes = EmployeeRepository.GetEmployeeTypes();

            return View(employee);
        }


        // GET: Success
        public ActionResult Success(int id)
        {
            var employee = EmployeeRepository.GetEmployeeById(id);
            if (employee == null)
            {
                return HttpNotFound();
            }
            return View(employee);
        }


    }
}