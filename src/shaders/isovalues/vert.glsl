void main() {
	// gl_Position is a special variable a vertex shader
	// is responsible for setting
	gl_Position = vec4(position, 1.0);
}
