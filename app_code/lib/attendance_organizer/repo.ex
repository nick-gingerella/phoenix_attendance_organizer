defmodule AttendanceOrganizer.Repo do
  use Ecto.Repo,
    otp_app: :attendance_organizer,
    adapter: Ecto.Adapters.Postgres
end
