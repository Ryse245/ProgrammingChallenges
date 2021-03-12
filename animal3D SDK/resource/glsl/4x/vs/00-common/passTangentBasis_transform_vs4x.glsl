/*
	Copyright 2011-2021 Daniel S. Buckstein

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

		http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.
*/

/*
	animal3D SDK: Minimal 3D Animation Framework
	By Daniel S. Buckstein
	
	passTangentBasis_transform_vs4x.glsl
	Calculate and pass tangent basis.
*/

#version 450

layout (location = 0) in vec4 aPosition;
layout (location = 1) in vec4 aNorm;
layout (location = 2) in vec4 aTangent;
//Or get matrices including all vertecies in object
layout (location = 0) in mat4 aVertexPositions;
layout (location = 1) in mat4 aVertexNorms;
layout (location = 2) in mat4 aVertexTangents;

flat out int vVertexID;
flat out int vInstanceID;

out mat4 vSurface

void main()
{
	// DUMMY OUTPUT: directly assign input position to output position
	gl_Position = aPosition;

	vVertexID = gl_VertexID;
	vInstanceID = gl_InstanceID;

	//PROGRAMMING CHALLENGE
	//Need to actually create surfaces based on input data
	//Issue: need more than one vector to make triangle for rendering
	vSurface: //calculate surface based on position matrix and normal matrix
}
