using System;
using System.Windows;
using HotelAppLibrary.Data;
using HotelAppLibrary.Models;

namespace HotelApp.Desktop
{
    /// <summary>
    /// CheckInForm.xaml 的交互邏輯
    /// </summary>
    public partial class CheckInForm : Window
    {
        private BookingFullModel? _data;
        private readonly IDatabaseData _db;

        public CheckInForm(IDatabaseData db)
        {
            InitializeComponent();
            _db = db ?? throw new ArgumentNullException(nameof(db));
        }

        /// <summary>
        /// 填充入住確認頁面的資訊
        /// </summary>
        /// <param name="data">預訂完整資料</param>
        public void PopulateCheckInfo(BookingFullModel data)
        {
            if (data == null)
            {
                MessageBox.Show("無法載入預訂資料", "錯誤", MessageBoxButton.OK, MessageBoxImage.Error);
                Close();
                return;
            }

            _data = data;

            firstNameText.Text = data.FirstName ?? string.Empty;
            lastNameText.Text = data.LastName ?? string.Empty;
            titleText.Text = data.Title ?? "未指定";
            roomNumberText.Text = data.RoomNumber ?? "—";           // ← 這裡修正拼寫：roomNumberText
            totalCostText.Text = string.Format("{0:C}", data.TotalCost);  // {0:C} 會自動帶貨幣符號
        }

        private void checkInUser_Click(object sender, RoutedEventArgs e)
        {
            if (_data == null || _data.Id <= 0)
            {
                MessageBox.Show("無效的預訂資料，無法完成入住", "錯誤", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            try
            {
                _db.CheckInGuest(_data.Id);
                MessageBox.Show("入住成功！", "完成", MessageBoxButton.OK, MessageBoxImage.Information);
                Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"入住失敗：{ex.Message}", "錯誤", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    }
}