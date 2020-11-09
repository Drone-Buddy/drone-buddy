$fn = 50;
rpi_brd_thickness = 1.6;
rpi_width = 56;
rpi_length = 85;
rpi_height = 16 + rpi_brd_thickness;

// Case Dimensions
case_brd_clearance_x = 3.9; // change this before printing
case_brd_clearance_y = 10;
case_brd_clearance_z = 5;
case_thickness = 2;
case_length = rpi_length + case_brd_clearance_x*2;
case_width = rpi_width + case_brd_clearance_y*2;
case_internal_height = rpi_height + case_brd_clearance_z*2;
bottom_case_internal_height = 0.6 * case_internal_height;
top_case_internal_height = 0.4 * case_internal_height;
case_corner_radius = 3;
echo(case_thickness = case_thickness);
echo(case_length = case_length);
echo(case_width = case_width);
echo(case_internal_height = case_internal_height);
echo(bottom_case_internal_height = bottom_case_internal_height);
echo(top_case_internal_height = top_case_internal_height);

// M3 Screw
screw_diameter = 3;
screw_insert_diameter = 4;

// Raspberry Pi Mounts
rpi_mounting_standoff_diameter = screw_insert_diameter + 2*2;
rpi_mounting_standoff_height = case_brd_clearance_z;
mounting_standoff_locations = [
  [3.5,3.5,-rpi_mounting_standoff_height],
  [3.5,3.5+49,-rpi_mounting_standoff_height],
  [3.5+58,3.5+49,-rpi_mounting_standoff_height],
  [3.5+58,3.5,-rpi_mounting_standoff_height]
];

// Case Assembly 
assembly_column_diameter = screw_insert_diameter + 2 * 2; // 2mm on either side of insert
assembly_column_radius = assembly_column_diameter / 2;
assembly_column_height = case_internal_height;
assembly_column_clearance = 0.5;
assembly_column_locations = [
  [0, -assembly_column_clearance-assembly_column_radius, 0],
  [0, assembly_column_clearance+assembly_column_radius, 0],
  [0, assembly_column_clearance+assembly_column_radius, 0],
  [0, -assembly_column_clearance-assembly_column_radius, 0]
] + [
  [-1.75,-3.5, 0],
  [-1.75,3.5, 0],
  [1.75,3.5, 0],
  [1.75,-3.5, 0],
] + mounting_standoff_locations;

// Port Dimensions
usb_c_width = 12;
usb_c_height= 3;
usb_c_port_clearance = 0.5;
usb_c_port_width = usb_c_width + 2*usb_c_port_clearance;
usb_c_port_height = usb_c_height + 2*usb_c_port_clearance;
usb_c_orientation = [90,0,0];
usb_c_location = [
  11.2, 
  -case_brd_clearance_y - case_thickness/2, 
  rpi_brd_thickness + usb_c_height/2
];

micro_hdmi_width = 7.2;
micro_hdmi_height = 2.8;
micro_hdmi_port_clearance = 0.5;
micro_hdmi_port_width = micro_hdmi_width + 2*micro_hdmi_port_clearance;
micro_hdmi_port_height = micro_hdmi_height + 2*micro_hdmi_port_clearance;
micro_hdmi_orientation = [90,0,0];
micro_hdmi_0_location = [
  26,
  -case_brd_clearance_y - case_thickness/2,
  rpi_brd_thickness + micro_hdmi_height/2
];
micro_hdmi_1_location = [
  39.5,
  -case_brd_clearance_y - case_thickness/2,
  rpi_brd_thickness + micro_hdmi_height/2
];

av_width = 7;
av_height = 6;
av_port_clearance = 0.5;
av_port_width = av_width + 2*av_port_clearance;
av_port_height = av_height + 2*av_port_clearance;
av_orientation = [90,0,0];
av_location = [
  54,
  -case_brd_clearance_y - case_thickness/2,
  rpi_brd_thickness + av_height/2
];

usb_3a_width = 14.5;
usb_3a_height = 16;
usb_3a_port_clearance = 0.5;
usb_3a_port_width = usb_3a_width + 2*usb_3a_port_clearance;
usb_3a_port_height = usb_3a_height + 2*usb_3a_port_clearance;
usb_3a_orientation = [90,0,90];
usb_3a_location = [
  85 + case_brd_clearance_x + case_thickness/2,
  27,
  rpi_brd_thickness + usb_3a_height/2
];

usb_2a_width = 14.7;
usb_2a_height = 16;
usb_2a_port_clearance = 0.5;
usb_2a_port_width = usb_2a_width + 2*usb_2a_port_clearance;
usb_2a_port_height = usb_2a_height + 2*usb_2a_port_clearance;
usb_2a_orientation = [90,0,90];
usb_2a_location = [
  85 + case_brd_clearance_x + case_thickness/2,
  9,
  rpi_brd_thickness + usb_2a_height/2
];

rj45_width = 15.5;
rj45_height = 13.5;
rj45_port_clearance = 0.5;
rj45_port_width = rj45_width + 2*rj45_port_clearance;
rj45_port_height = rj45_height + 2*rj45_port_clearance;
rj45_orientation = [90,0,90];
rj45_location = [
  85 + case_brd_clearance_x + case_thickness/2,
  45.75,
  rpi_brd_thickness + rj45_height/2
];

camera_length = 22.6;
camera_width = 2;
camera_port_clearance = 0.5;
camera_port_length = camera_length + 2*camera_port_clearance;
camera_port_width = camera_width + 2*camera_port_clearance;
camera_orientation = [0,0,90];
camera_location = [
  45.9,
  1.7 + case_brd_clearance_y,
  case_internal_height - case_brd_clearance_z + case_thickness/2
];

gpio_port_width = 3;
gpio_port_height = 3;
gpio_orientation = [90,0,0];
gpio_location = [
  15,
  rpi_width + case_brd_clearance_y + case_thickness/2,
  rpi_brd_thickness + gpio_port_height / 2
];

module shell(length, width, height, corner_radius, thickness) {
  x0 = 0+corner_radius;
  y0 = 0+corner_radius;
  x1 = length-corner_radius;
  y1 = width-corner_radius;
  z = 0;

  inside_points = [ [x0,y0,z], [x0,y1,z], [x1,y1,z], [x1,y0,z] ];
  outside_points = [ 
    [-thickness,-thickness,-thickness], 
    [-thickness,thickness,-thickness],
    [thickness,thickness,-thickness],
    [thickness,-thickness,-thickness] 
  ] + inside_points;
  difference() {
    hull() {
      for (p = outside_points) {
        translate(p) cylinder(r=corner_radius, h=height+thickness);
      }
    }
    hull() {
      for (p = inside_points) {
        translate(p) cylinder(r=corner_radius, h=height+0.01);
      }
    }
  }
}

module column(location, diameter, height) {
  translate(location) cylinder(d=diameter, h=height);
}

module slot(location, orientation, length, width, corner_radius, thickness) {
  x0 = -length/2 + corner_radius;
  y0 = -width/2 + corner_radius;
  x1 = length/2 - corner_radius;
  y1 = width/2 - corner_radius;
  z = 0;

  points = [ [x0,y0,z], [x0,y1,z], [x1,y1,z], [x1,y0,z] ];
  translate(location) 
  rotate(a=orientation) 
  hull() {
    for (p = points) {
      translate(p) cylinder(r=corner_radius, h=thickness, center=true);
    }
  }
}


difference() {
  union() {
    // Raspberry Pi (for reference)
    translate([rpi_length/2, rpi_width/2, rpi_brd_thickness/2])
    import("Raspberry Pi 4B/Raspberry Pi 4 Model B.stl");

    // Bottom Shell
    translate([-case_brd_clearance_x,
               -case_brd_clearance_y,
               -case_brd_clearance_z])
    shell(length=case_length,
          width=case_width,
          height=bottom_case_internal_height,
          corner_radius=case_corner_radius,
          thickness=case_thickness);

    // Top Shell
    translate([0,case_width,case_internal_height])
    translate([-case_brd_clearance_x,
               -case_brd_clearance_y,
               -case_brd_clearance_z])
    rotate([180,0,0])
    shell(length=case_length,
          width=case_width,
          height=top_case_internal_height,
          corner_radius=case_corner_radius,
          thickness=case_thickness);

    // Mounting Standoffs
    for (p = mounting_standoff_locations) {
      difference() {
        column(location=p, 
               diameter=rpi_mounting_standoff_diameter,
               height=rpi_mounting_standoff_height);
        translate(p+[0,0,0.01]) 
        cylinder(d=screw_insert_diameter, h=rpi_mounting_standoff_height);
      }
    }

    // Assembly columns (positioned relative to mounting standoffs)
    for (p = assembly_column_locations) {
      difference() {
        column(location=p, 
               diameter=assembly_column_diameter,
               height=assembly_column_height);
        translate(p+[0,0,0.01])
        cylinder(d=screw_insert_diameter, h=assembly_column_height);
      }
    }
  }

  for (p = assembly_column_locations) {
    column(location=p + [0,0,assembly_column_height-0.01], 
           diameter=screw_diameter+0.5,
           height=case_thickness+0.1);
  }

  // Slots
  slot(location=usb_c_location,
       orientation=usb_c_orientation,
       length=usb_c_port_width,
       width=usb_c_port_height,
       corner_radius=1,
       thickness=case_thickness+0.1);
  slot(location=usb_3a_location,
       orientation=usb_3a_orientation, 
       length=usb_3a_port_width, 
       width=usb_3a_port_height,
       corner_radius=1, 
       thickness=case_thickness+0.1);
  slot(location=usb_2a_location,
       orientation=usb_2a_orientation,
       length=usb_2a_port_width,
       width=usb_2a_port_height,
       corner_radius=1,
       thickness=case_thickness+0.1);
  slot(location=rj45_location,
       orientation=rj45_orientation,
       length=rj45_port_width,
       width=rj45_port_height,
       corner_radius=1,
       thickness=case_thickness+0.1);
  slot(location=camera_location,
     orientation=camera_orientation,
     length=camera_port_length,
     width=camera_port_width,
     corner_radius=1,
     thickness=case_thickness+0.1);
  slot(location=gpio_location,
       orientation=gpio_orientation,
       length=gpio_port_width,
       width=gpio_port_height,
       corner_radius=1,
       thickness=case_thickness+0.1);
}

