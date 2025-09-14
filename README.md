# 📂 Thư mục Database

Thư mục này được sử dụng để lưu trữ các file liên quan đến **cơ sở dữ liệu** của dự án.  
Mục đích là quản lý dữ liệu một cách có tổ chức và dễ dàng truy cập.

## 📑 Nội dung
- `backup/` : Lưu các bản sao lưu (backup) định kỳ.
- `scripts/` : Chứa các script SQL dùng để tạo bảng, thêm dữ liệu mẫu hoặc cập nhật dữ liệu.
- `migrations/` : Quản lý các file migration để thay đổi cấu trúc database theo từng phiên bản.
- `data/` : Lưu dữ liệu xuất/nhập ở định dạng CSV, JSON hoặc SQL dump.

## 🛠️ Cách sử dụng
1. Đặt các file cơ sở dữ liệu (`.sql`, `.db`, `.csv`, ...) vào thư mục phù hợp.
2. Khi cần khôi phục dữ liệu, hãy sử dụng file trong thư mục `backup/`.
3. Thực thi các script trong thư mục `scripts/` để khởi tạo hoặc cập nhật database.

## ⚠️ Lưu ý
- Không commit các file chứa **thông tin nhạy cảm** như mật khẩu, dữ liệu cá nhân lên repository công khai.
- Nên thêm file `.gitignore` để loại trừ các file database thực tế (ví dụ: `*.db`, `*.sqlite`, `*.sql`) nếu không cần thiết chia sẻ.

---
✍️ *README này giúp đảm bảo mọi người trong dự án đều hiểu cách quản lý và sử dụng thư mục database một cách thống nhất.*
