package app;

using magic.StructureTools;

class Store<S:State> {
	private var state(null, null):State;

	private function new(s:S) {
		this.state = s;
	}

	public function getState():S {
		return cast state;
	}

	public function setState(partialState:State) {
		var old = state;
		state = {example: state.example}.combine(this.state, partialState);
		for (l in stateChangeListeners)
			l.onStateChange(old, state);
	}

	private var stateChangeListeners:Array<StateChangeListener> = [];

	public function addStateChangeListener(l:StateChangeListener) {
		stateChangeListeners.push(l);
	}

	private static var instance:Store<State>;

	public static function getInstance() {
		if (instance == null) {
			throw "must call init() before getInstance()";
		}
		return instance;
	}

	public static function init(state:State) {
		if (instance != null) {
			throw "instance already initialized";
		}
		instance = new Store<State>(state);
	}
}

typedef StateChangeListener = {
	function onStateChange(old:State, newState:State):Void;
}
