$fn = 200;

logo_file = "./adam-map.png";

ball_diameter = 216;

height = 15;
thickness = 5;
od = 110;
id = 79;

top_rim = 2;
bottom_rim = 4;

image_width = 500;
image_height = 100;
logo_diameter = id - 2;
logo_height = 2;
logo_overlap = 0.1;


module logo() {
    difference() {
        translate([0, 0, thickness - logo_overlap])
        scale([logo_diameter / image_width, logo_diameter / image_width, (logo_height + logo_overlap) / image_height])
            surface(logo_file, center=true);
        
        
    cylinder(h = thickness, r = od / 2, center=false);
    }
}



module print_head_1() {
    difference() {
        cylinder(h = 50, r1 = od/2, r2 = 0, center = false);

        translate([0,0,thickness])
            cylinder(h=200, r1 = id/2, r2 = id/2, center = false);
            
        translate([0,0,height-top_rim])
            cylinder(h=200, r1 = od, r2 = od, center = false);
        
        translate([0, 0, -.001])
        cylinder(h = bottom_rim, r1 = od/2, r2 = od/2, center = false);
    }
}

module print_head_2(hex_color="#990099") {
    color(hex_color){
        difference() {
            union() {
                cylinder(h = bottom_rim, r1 = od/2, r2 = od/2, center = false);
                logo();
            }
            print_head_1();
        }
    }
}

//print_head_2();

print_head_1();

