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
	
	drawColorAttrib_fs4x.glsl
	Draw color attribute passed from prior stage as varying.


#version 450

layout (location = 0) out vec4 rtFragColor;

void main()
{
	// DUMMY OUTPUT: all fragments are OPAQUE ORANGE
	rtFragColor = vec4(1.0, 0.5, 0.0, 1.0);
}*/

#version 450

in vec4 vPosition_clip;

//Sphere Information
in Sampler2D sphereTex;	//If sphere is textured
in vec4 spherePos; //Centerpoint of sphere
in vec4 sphereData;	//Vec4 containing radius, radius squared, radius inverse, radius square inverse
in mat4 sphereObjViewMat;
in mat4 sphereViewObjMat;

uniform mat4 uProjectionMat, uProjectionMatInv;

struct sRay
{
    vec4 origin;    // w = 1
    vec4 direction; // w = 0
};

struct sSphere
{
    mat4 object2view; // model-view matrix; center is fourth column
    mat4 view2object; // model-view inverse matrix
	vec4 position;
    float radius, radiusSq, radiusInv, radiusSqInv;
};


const vec4 kOrigin = vec4(0.0, 0.0, 0.0, 1.0);

layout (location = 0) out vec4 cFragColor;
layout (location = 1) out vec4 cFragNormal;
layout (location = 2) out vec4 cFragPosition;
layout (location = 3) out vec4 cFragTexcoord;
//out float gl_FragDepth; // built-in variable for depth; leave commented

void main()
{
	//Default returns, if ray does not hit send these
    cFragColor = vec4(1.0);
    cFragNormal = vec4(0.0);
    cFragPosition = kOrigin;
    cFragTexcoord = kOrigin;
    //gl_FragDepth = 1.0;
	
	//Set up sphere with passed-in data
	sSphere sceneSphere;
	sceneSphere.object2view = sphereObjViewMat;
	sceneSphere.view2object = sphereViewObjMat;
	sceneSphere.position = spherePos;
	sceneSphere.radius = sphereData[0];
	sceneSphere.radiusSq = sphereData[1];
	
    sRay ray;
    ray.origin = kOrigin;
    ray.direction = uProjectionMatInv * vPosition_clip;
    ray.direction = ray.direction / ray.direction.w - ray.origin;

	vec4 sphereViewPos = sceneSphere.object2view * sceneSphere.position;
	vec3 sphereViewPos3D = sphereViewPos.xyz;
	vec3 rayPos3D = ray.origin.xyz;
	vec3 rayDir3D = ray.direction.xyz;

	vec3 rayHitPosition = (rayPos3D+rayDir3D-SphereViewPos3D);

	float rayHitCheck = dot(rayHitPosition,rayHitPosition) - sceneSphere.radiusSq;	//If this == 0, on sphere

	//If statement not efficient, but not sure how else to do this
	if(rayHitCheck == 0)
	{
		cFragPosition = rayHitPosition; //Maybe? Since the object2view matrix was used, I believe that this is the position of the ray hit in view-space
		//On Sphere, get data to send
		//Get color off of sphere, as well as texture position
		//Use view2object with hit point and sphere texture to find texture coordinate
		//Use texture coordinate and texture to find color

		//Finding normal: use the vPositionClip and the rayHitPosition (maybe cross product? not sure) to calculate normal vector?
	}
	gl_FragDepth = 1-rayHitCheck; //depth of shader is 1 if ray hits sphere, less if it does not

}