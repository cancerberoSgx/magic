package examples;

import app.*;

typedef Example = {
	public var name:String;
	public var description:String;
	public var script:(state:State) -> String;
}

class Examples {
	public static var list:Array<Example> = [
		{
			name: 'scale-rotate',
			script: state -> [
				'convert',
				state.inputFiles[0].name,
				'-scale',
				'70%',
				'-rotate',
				'33',
				'scaled-rotated.jpg'
			].join(' '),
			description: "Simple command that scale and rotates the image"
		},
		{
			name: 'identify',
			script: state -> 'identify ${state.inputFiles.map(f -> f.name).join(" ")}',
			description: "just calls identify to get information of the image"
		},
		{
			name: 'animation-one-command',
			description: 'Generates several intermediate output files incrementing rotation and with all of them a final .gif. Uses +clone and parenthesis',
			script: state ->
			'convert ${state.inputFiles[0].name} -scale 50% -virtual-pixel mirror ( +clone -distort SRT 22.5 ) ( +clone -distort SRT 22.5 ) ( +clone -distort SRT 22.5 ) ( +clone -distort SRT 22.5 ) ( +clone -distort SRT 22.5 ) ( +clone -distort SRT 22.5 ) ( +clone -distort SRT 22.5 ) ( +clone -distort SRT 22.5 ) ( +clone -distort SRT 22.5 ) ( +clone -distort SRT 22.5 ) ( +clone -distort SRT 22.5 ) ( +clone -distort SRT 22.5 ) ( +clone -distort SRT 22.5 ) ( +clone -distort SRT 22.5 ) ( +clone -distort SRT 22.5 ) ( +clone -distort SRT 22.5 ) output.gif'
		},
		{
			name: 'gif-wave-swirl-gif',
			script: state -> 'convert -swirl 123 -wave 14x95 -scale 74% -rotate 15 -background transparent ${state.inputFiles[0].name} foo22.gif',
			description: 'perform a series of complex effects over an animated gif which results in another animated transformed gif.'
		},
	{
			name: 'build-animation',
			script: state -> '
convert -size 101x101 radial-gradient: \\
( -clone 0 -level 00,100% +level-colors ,#F00 ) \\
( -clone 0 -level 10,100% +level-colors ,#F12 ) \\
( -clone 0 -level 20,100% +level-colors ,#F24 ) \\
( -clone 0 -level 30,100% +level-colors ,#F36 ) \\
( -clone 0 -level 40,100% +level-colors ,#F46 ) \\
-delete 0  -duplicate 1,-2-1 -set delay 1x30 -loop 0 out_pulsing_anim.gif',
			description: 'Generates a radial-gradient image, which is then cloned and adjusted to create a red to brighter red-orange pulse. This is then duplicated to create a reversed Patrol Cycle before creating a 30 second, looped'
		},
			{
        name: 'spread-paint',
			script: state -> 'convert ${state.inputFiles[0].name} -interpolate Average -spread 5 output0.jpg',
			description: 'displace image pixels by a random amount. The argument amount defines the size of the neighborhood around each pixel from which to choose a candidate pixel to blend. The lookup is controlled by the -interpolate setting.'
		},
  {
    name: 'blur-variable',
    // tags: [ExampleTag.artistic, ExampleTag.distort],
    description: 'https://www.imagemagick.org/Usage/mapping/#blur_angle',
    script: state -> '
convert -size 406x406 radial-gradient: -negate \\
  -gravity center -crop 375x375+0+0 +repage gradient_radial.jpg
convert gradient_radial.jpg gradient_radial.jpg gradient_polar.jpg \\
  -channel RGB -combine blur_map_polar.jpg
convert ${state.inputFiles[0].name} blur_map_polar.jpg \\
  -compose blur -define compose:args=10x0+0+360 -composite \\
  blur_polar.jpg
convert ${state.inputFiles[0].name} blur_map_polar.jpg \\
  -compose blur -define compose:args=5x0+90+450 -composite \\
  blur_radial.jpg
convert ${state.inputFiles[0].name} blur_map_polar.jpg \\
  -compose blur -define compose:args=10x0+0+180 -composite \\
  blur_weird.jpg
'
  },


//   {
//     name: 'text comet and smoked',
//     // tags: [ExampleTag.text, ExampleTag.color],
//     description: 'Comet font: one of the specialised blurs operators, "-motion-blur" allows you to create a comet like tail to objects in an image. 
//     Smoking Font: combining this with wave and you can make the comet font look like smoke, a smell, or even flames are rising off the font!',
//     script: state -> '<% 
// const angle=44 
// const intensity=44
// const fontSize=55
// const imageWidth=500
// const imageHeight=200
// const font='waltographUI.ttf'
// %>

// # build the font passing url and giving it the name 'font1.ttf'
// buildFile <%= font %> font1.ttf

// convert -size <%=imageWidth %>x<%= imageHeight %> xc:lightblue  -font font1.ttf  -pointsize <%= fontSize %> \\
//   -fill navy   -annotate +<%= imageWidth/10 %>+<%= imageHeight/1.7 %> 'Comet Font' -motion-blur 0x<%= intensity %>+<%= angle %> \\
//   -fill black  -annotate +<%= imageWidth/10 %>+<%= imageHeight/1.7 %> 'Comet Font' -motion-blur 0x1+<%= angle %> \\
//   out1_comet_font.jpg

// convert -size <%=imageWidth %>x<%= imageHeight %> xc:lightblue  -font font1.ttf  -pointsize <%= fontSize %> \\
//   -fill black  -annotate +<%= imageWidth/10 %>+<%= imageHeight/1.7 %> 'Smoked Font' -motion-blur 0x<%= intensity %>+<%= angle %> \\
//   -background lightblue -wave 3x35 \\
//   -fill navy   -annotate +<%= imageWidth/10 %>+<%= imageHeight/1.7 %> 'Smoked Font'  \\
//   out2_smoked_font.jpg
//   '.trim(),
//   },




  {
    name: 'generate-pdf',
    description: 'runs identify program to print to stdout image info',
 script: state -> '
montage \\
  null: \\
  ( rose: -rotate -90 -resize 66% ) \\
  null: \\
  ( logo: -rotate -90 -resize 66% ) \\
  ${state.inputFiles.map(f->f.name).join(' ')} \\
  -page A4 -tile 2x3 -geometry +10+10 -shadow -frame 8 \\
  output.pdf'
    // tags: [ExampleTag.info],
  },


  {
    name: 'color wheels',
    description: 'https://imagemagick.org/Usage/color_basics/',
 script: state -> '
convert -size 100x300 gradient: -rotate 90 \\
    -distort Arc \'360 -90.1 50\' +repage \\
    -gravity center -crop 100x100+0+0 +repage  angular.png
convert -size 100x100 xc:white                     solid.png
convert -size 100x100 radial-gradient: -negate     radial.png

convert angular.png solid.png radial.png \\
    -combine -set colorspace HSL \\
    -colorspace sRGB colorwheel_HSL.png
convert angular.png solid.png radial.png \\
    -combine -set colorspace HSB \\
    -colorspace sRGB colorwheel_HSB.png
convert angular.png solid.png radial.png \\
    -combine -set colorspace HCL \\
    -colorspace sRGB colorwheel_HCL.png
convert angular.png solid.png radial.png \\
    -combine -set colorspace HCLp \\
    -colorspace sRGB colorwheel_HCLp.png

convert -size 100x100 xc:black \\
    -fill white  -draw \'circle 49.5,49.5 40,4\' \\
    -fill black  -draw \'circle 49.5,49.5 40,30\' \\
    -alpha copy -channel A -morphology dilate diamond anulus.png
convert angular.png -size 100x100 xc:white xc:gray50 \\
    -combine -set colorspace HSL -colorspace RGB \\
    anulus.png -alpha off -compose Multiply -composite \\
    anulus.png -alpha on  -compose DstIn -composite \\
    -colorspace sRGB hues_HSL.png

convert angular.png -size 100x100 xc:white xc:gray50 \\
    -combine -set colorspace HCL -colorspace RGB \\
    anulus.png -alpha off -compose Multiply -composite \\
    anulus.png -alpha on  -compose DstIn -composite \\
    -colorspace sRGB hues_HCL.png

convert radial.png solid.png angular.png \\
    -combine -set colorspace LCHab \\
    -colorspace sRGB colorwheel_LCHab.png
convert radial.png solid.png angular.png \\
    -combine -set colorspace LCHuv \\
    -colorspace sRGB colorwheel_LCHuv.png

    '
  }

  // {
  //   name: 'warping local region',
  //   description: `https://imagemagick.org/Usage/masking/#region_warping`,
  //   command: `
  //   convert -size 600x70 xc:darkred \\
  //   -fill white -draw 'roundrectangle 5,5  595,65 5,5' \\
  //   -fill black -draw 'rectangle 5,25 595,31' \\
  //   -fill red -draw 'rectangle 5,39 595,45' \\
  //   lines.gif
  // convert lines.gif \\
  //   -region 90x70+10+0    -swirl  400  \\
  //   -region 90x70+100+0   -swirl  400 \\
  //   -region 90x70+190+0   -swirl -400 \\
  //   -region 120x70+280+0  -implode 1.5 \\
  //   -region 100x70+380+0  -implode -7  \\
  //   -region 101x70+480+0  -wave 10x50 -crop 0x70+0+10! \\
  //   +region \`uniqueName\`_warping_regions.gif
  //   `.trim(),
  //   tags: [ExampleTag.drawing],
  // },


	];
}
