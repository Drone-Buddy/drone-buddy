$fn = 50;
rpi_board_thickness = 1.8;
rpi_width = 56;
rpi_length = 85;
rpi_height = 16 + rpi_board_thickness;

case_board_clearance_x = 4;
case_board_clearance_y = 2.5;
case_board_clearance_z = 3;
case_thickness = 1.6;
case_length = rpi_length + case_board_clearance_x*2;
case_width = rpi_width + case_board_clearance_y*2;
case_height = rpi_height + case_board_clearance_z;
case_border_radius = 3;
case_mounting_standoff_diameter = 6;
case_mounting_standoff_height = case_board_clearance_z;
case_mounting_post_diameter = 2.5;
case_mounting_post_clearance = 0.5;
case_mounting_post_height = 4;

board_offset = [case_board_clearance_x, case_board_clearance_y, case_board_clearance_z];
translate(board_offset) translate([rpi_length/2, rpi_width/2, rpi_board_thickness/2]) import("Raspberry Pi 4B/Raspberry Pi 4 Model B.stl");

module shell(length, width, height, border_radius) {
  points = [[0+border_radius,0+border_radius,0],[0+border_radius,width-border_radius,0],[length-border_radius,width-border_radius,0],[length-border_radius,0+border_radius,0]];

  hull() {
    for (p = points) {
      translate(p) cylinder(r=case_border_radius, h=case_height);
    }
  }
}
%shell(case_length, case_width, case_height, case_border_radius);

mounting_standoff_locations = [
  [3.5,3.5,-case_mounting_standoff_height],
  [3.5,3.5+49,-case_mounting_standoff_height],
  [3.5+58,3.5+49,-case_mounting_standoff_height],
  [3.5+58,3.5,-case_mounting_standoff_height]
];
for (p = mounting_standoff_locations) {
  translate(board_offset) translate(p) cylinder(d=case_mounting_standoff_diameter, h=case_mounting_standoff_height);
}

mounting_post_locations = [
  [3.5,3.5,0],
  [3.5,3.5+49,0],
  [3.5+58,3.5+49,0],
  [3.5+58,3.5,0]
];
for (p = mounting_post_locations) {
    translate(board_offset) translate(p) cylinder(d=case_mounting_post_diameter-case_mounting_post_clearance, h=case_mounting_post_height);
}
