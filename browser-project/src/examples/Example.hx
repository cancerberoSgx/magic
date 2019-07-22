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
		}




	];
}
