$fn = 200;

logo_file = "./matthew.png";

ball_diameter = 216;
ball_radius = ball_diameter / 2;

height = 15;
od = 100;
id = 79;
ir = id / 2;

// Calculate the height of the ball that sits inside the top rim
ball_clearance = ball_radius - sqrt(pow(ball_radius, 2) - pow(ir, 2));


top_rim = 2;

image_width = 500;
image_height = 100;
logo_diameter = id - 2;
logo_height = 1;
floor_height = 1;
logo_overlap = 0.1;

ball_holder_height = floor_height + logo_height + 1.25 * ball_clearance;

base_lip = 4;
top_lip = 2;
base_thickness = 3;


module logo() {
    difference() {
        translate([0,0, -.05])
        scale([logo_diameter / image_width, logo_diameter / image_width, (logo_height + logo_overlap) / image_height])
            surface(logo_file, center=true);
        
        translate([-logo_diameter, -logo_diameter, -.1])
        cube([3 * logo_diameter, 3 * logo_diameter, .1]);
    }
}

module base() {
    difference() {
        // Draw a lipped cylinder...
        hull () {
            cylinder(r1=od/2, r2=0, h=base_thickness + .001 - base_lip);
            translate([0,0,base_thickness - base_lip]) rotate_extrude() translate([od/2,0]) circle(r=base_lip);
        }
        // Then cut out everything below the bottom
        translate([0, 0, -20])
        cylinder(r=od, h=20);
    }
}

module ball_holder() {
    difference() {
        // Outside portion of ball stand    
        cylinder(r1=od/2, r2=ir + top_lip, h=ball_holder_height);
        // Cut out interior portion of ball stand
        translate([0, 0, floor_height])
            cylinder(r=ir, h=ball_holder_height);
    }
}

module print_head_1() {
    translate([0, 0, base_thickness])
        ball_holder();
}

module print_head_2(hex_color="#990099") {
    color(hex_color){
        difference() {
            union() {
                base();
                
                translate([0, 0, base_thickness + floor_height])
                logo();
            }
            print_head_1();
        }
    }
}


print_head_2();
//print_head_1();

