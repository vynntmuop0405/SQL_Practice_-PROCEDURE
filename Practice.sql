## Bài 1: Thêm mới khách hàng: Tạo Procedure thêm mới khách hàng vào bảng Customers.
 #### Yêu cầu:
 ##### Input: Tên khách hàng, Ngày sinh, Số điện thoại
 ##### Nếu trùng số điện thoại đã có → Thông báo lỗi
 ##### Ngược lại → Insert

CREATE OR ALTER PROCEDURE Insert_customers
	@Customer_name NVARCHAR(50),
	@Birthday NVARCHAR(50),
	@Phone VARCHAR(50)
AS
BEGIN
--- Check duplicate of phone number
IF EXISTS (SELECT 1 FROM PROCEDURE_CUSTOMERS WHERE phone = @Phone)
BEGIN
--- Raise duplicate
RAISERROR( N'Số điện thoại đã tồn tại trong hệ thống!', 16,1) -- 16 Nghĩa là lỗi do người dùng
RETURN
END
--- Insert if new phone number is a new unique
INSERT INTO PROCEDURE_CUSTOMERS
	VALUES(@Phone, @Customer_name, @Phone, @Birthday)
END

--TEST
EXEC Insert_customers @Customer_name='LÊ THÁI SƠN', @Birthday = '1998-11-29', @Phone = '0965840457';

## Bài 2: Cập nhật thông tin khách hàng: Cho phép sửa thông tin khách hàng (Tên, Ngày sinh) khi biết CustomerID
 #### Yêu cầu:
 ##### Kiểm tra tồn tại CustomerID
 ##### Nếu có → Update
 ##### Nếu không → Thông báo không tồn tại