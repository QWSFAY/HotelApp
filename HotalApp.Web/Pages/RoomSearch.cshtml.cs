using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using HotelAppLibrary.Data;
using HotelAppLibrary.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace HotalApp.Web.Pages  
{
    public class RoomSearchModel : PageModel
    {
        private readonly IDatabaseData _db;

        [BindProperty(SupportsGet =true)] 
        [DataType(DataType.Date)]
        public DateTime StartDate { get; set; } = DateTime.Today;   // 用 Today，不要用 Now

        [BindProperty(SupportsGet =true)]
        [DataType(DataType.Date)]
        public DateTime EndDate { get; set; } = DateTime.Today.AddDays(1);

        [BindProperty(SupportsGet = true)]
        public bool SearchEnabled { get; set; } = false;

        public List<RoomTypeModel> AvailableRoomTypes { get; set; }

        public RoomSearchModel(IDatabaseData db)
        {
            _db=db;
        }

        public void OnGet()
        {
                if (SearchEnabled == true)
            {
                AvailableRoomTypes = _db.GetAvailableRoomTypes(StartDate, EndDate);
            }
        }

        public IActionResult OnPost()
        {
          
          return RedirectToPage(new 
          {SearchEnabled=true,
              StartDate=StartDate.ToString("yyyy-MM-dd"),
              EndDate=EndDate.ToString("yyyy-MM-dd")
          });
        }
    }
}