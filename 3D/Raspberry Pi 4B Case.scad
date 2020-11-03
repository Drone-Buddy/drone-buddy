$fn = 50;
rpi_brd_thickness = 1.8;
rpi_width = 56;
rpi_length = 85;
rpi_height = 16 + rpi_brd_thickness;

// Case Dimensions
case_brd_clearance_x = 4.2;
case_brd_clearance_y = 2.5;
case_brd_clearance_z = 4;
case_thickness = 1.6;
case_length = rpi_length + case_brd_clearance_x*2;
case_width = rpi_width + case_brd_clearance_y*2;
case_height = rpi_height + case_brd_clearance_z + 4;
case_corner_radius = 3;
case_mounting_standoff_diameter = 6;
case_mounting_standoff_height = case_brd_clearance_z;

// Port Dimensions
usb_c_length = 8.65;
usb_c_width = 2.65;
usb_c_port_clearance = 0.5;
usb_c_port_length = usb_c_length + 2*usb_c_port_clearance;
usb_c_port_width = usb_c_width + 2*usb_c_port_clearance;
usb_c_orientation = [90,0,0];
usb_c_location = [11.2, -case_brd_clearance_y - case_thickness/2, rpi_brd_thickness + usb_c_width/2];

micro_hdmi_length = 7.2;
micro_hdmi_width = 2.8;
micro_hdmi_port_clearance = 0.5;
micro_hdmi_port_length = micro_hdmi_length + 2*micro_hdmi_port_clearance;
micro_hdmi_port_width = micro_hdmi_width + 2*micro_hdmi_port_clearance;
micro_hdmi_orientation = [90,0,0];
micro_hdmi_0_location = [26, -case_brd_clearance_y - case_thickness/2, rpi_brd_thickness + micro_hdmi_width/2];
micro_hdmi_1_location = [39.5, -case_brd_clearance_y - case_thickness/2, rpi_brd_thickness + micro_hdmi_width/2];

av_length = 7;
av_width = 6;
av_port_clearance = 0.5;
av_port_length = av_length + 2*av_port_clearance;
av_port_width = av_width + 2*av_port_clearance;
av_orientation = [90,0,0];
av_location = [54, -case_brd_clearance_y - case_thickness/2, rpi_brd_thickness + av_width/2];

usb_3a_length = 14.5;
usb_3a_width = 16;
usb_3a_port_clearance = 0.5;
usb_3a_port_length = usb_3a_length + 2*usb_3a_port_clearance;
usb_3a_port_width = usb_3a_width + 2*usb_3a_port_clearance;
usb_3a_orientation = [90,0,90];
usb_3a_location = [85 + case_brd_clearance_x + case_thickness/2, 27, rpi_brd_thickness + usb_3a_width/2];

usb_2a_length = 14.7;
usb_2a_width = 16;
usb_2a_port_clearance = 0.5;
usb_2a_port_length = usb_2a_length + 2*usb_2a_port_clearance;
usb_2a_port_width = usb_2a_width + 2*usb_2a_port_clearance;
usb_2a_orientation = [90,0,90];
usb_2a_location = [85 + case_brd_clearance_x + case_thickness/2, 9, rpi_brd_thickness + usb_2a_width/2];

rj45_length = 15.5;
rj45_width = 13.5;
rj45_port_clearance = 0.7;
rj45_port_length = rj45_length + 2*rj45_port_clearance;
rj45_port_width = rj45_width + 2*rj45_port_clearance;
rj45_orientation = [90,0,90];
rj45_location = [85 + case_brd_clearance_x + case_thickness/2, 45.75, rpi_brd_thickness + rj45_width/2];

module shell(length, width, height, corner_radius, thickness) {
  x0 = 0+corner_radius;
  y0 = 0+corner_radius;
  x1 = length-corner_radius;
  y1 = width-corner_radius;
  z = 0;

  inside_points = [ [x0,y0,z], [x0,y1,z], [x1,y1,z], [x1,y0,z] ];
  outside_points = [ [x0-thickness,y0-thickness,z-thickness], [x0-thickness,y1+thickness,z-thickness],[x1+thickness,y1+thickness,z-thickness],[x1+thickness,y0-thickness,z-thickness] ];
  difference() {
    hull() {
      for (p = outside_points) {
        translate(p) cylinder(r=corner_radius, h=case_height);
      }
    }
    hull() {
      for (p = inside_points) {
        translate(p) cylinder(r=corner_radius, h=case_height);
      }
    }
  }
}

module mounting_standoff(location, diameter, height) {
  translate(location) cylinder(d=diameter, h=height);
}

module slot(location, orientation, length, width, corner_radius, thickness) {
  x0 = -length/2 + corner_radius;
  y0 = -width/2 + corner_radius;
  x1 = length/2 - corner_radius;
  y1 = width/2 - corner_radius;
  z = 0;

  points = [ [x0,y0,z], [x0,y1,z], [x1,y1,z], [x1,y0,z] ];
  translate(location) rotate(a=orientation) hull() {
    for (p = points) {
      translate(p) cylinder(r=corner_radius, h=thickness, center=true);
    }
  }
}


difference() {
  union() {
    // Raspberry Pi (for reference)
    *translate([rpi_length/2, rpi_width/2, rpi_brd_thickness/2]) import("Raspberry Pi 4B/Raspberry Pi 4 Model B.stl");

    // Bottom Shell
    translate([-case_brd_clearance_x, -case_brd_clearance_y, -case_brd_clearance_z]) shell(case_length, case_width, case_height, case_corner_radius, case_thickness);

    // Mounting Standoffs
    mounting_standoff_locations = [
      [3.5,3.5,-case_mounting_standoff_height],
      [3.5,3.5+49,-case_mounting_standoff_height],
      [3.5+58,3.5+49,-case_mounting_standoff_height],
      [3.5+58,3.5,-case_mounting_standoff_height]
    ];
    for (p = mounting_standoff_locations) {
      mounting_standoff(location=p, diameter=case_mounting_standoff_diameter, height=case_mounting_standoff_height);
    }
  }

  // Slots
  slot(location = usb_c_location, orientation=usb_c_orientation, length=usb_c_port_length, width=usb_c_port_width, corner_radius=1, thickness=case_thickness+0.1);
  slot(location = micro_hdmi_0_location, orientation=micro_hdmi_orientation, length=micro_hdmi_port_length, width=micro_hdmi_port_width, corner_radius=1, thickness=case_thickness+0.1);
  slot(location = micro_hdmi_1_location, orientation=micro_hdmi_orientation, length=micro_hdmi_port_length, width=micro_hdmi_port_width, corner_radius=1, thickness=case_thickness+0.1);
  slot(location = av_location, orientation=av_orientation, length=av_port_length, width=av_port_width, corner_radius=1, thickness=case_thickness+0.1);
  slot(location = usb_3a_location, orientation=usb_3a_orientation, length=usb_3a_port_length, width=usb_3a_port_width, corner_radius=1, thickness=case_thickness+0.1);
  slot(location = usb_2a_location, orientation=usb_2a_orientation, length=usb_2a_port_length, width=usb_2a_port_width, corner_radius=1, thickness=case_thickness+0.1);
  slot(location = rj45_location, orientation=rj45_orientation, length=rj45_port_length, width=rj45_port_width, corner_radius=1, thickness=case_thickness+0.1);
}



