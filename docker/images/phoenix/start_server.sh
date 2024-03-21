#/bin/bash

# if hello_world directory exists, assume it was made using 'mix phx.new hello_world'
if [ -d "attendance_organizer" ]; then
  # start phoenix server using mix phx.server
  cd attendance_organizer
  mix phx.server
fi
