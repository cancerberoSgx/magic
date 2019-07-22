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
	];
}
