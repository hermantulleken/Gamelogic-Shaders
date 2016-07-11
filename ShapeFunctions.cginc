// www.gamelogic.co.za

// Contains functions useful for making shaders that renders regular shapes such as circles and hexagons.

struct VertexUVAppData
{
	float4 vertex : POSITION;
	float2 uv : TEXCOORD0;
};

struct VertexUV
{
	float4 vertex : SV_POSITION;
	float2 uv : TEXCOORD0;	
}; 

VertexUV vert(VertexUVAppData v)
{
	VertexUV o;
	o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
	o.uv = v.uv;

	return o;
}

float GetCircleAlpha(float2 uv)
{
	float x = uv.x - 0.5;
	float y = uv.y - 0.5;
	float r = x*x + y*y;
	float border = fwidth(r);
	float alpha = 1;
	
	if (r > 0.25) alpha = 0;
	else if (r + border > 0.25) alpha = (0.25 - r) / border;

	return alpha;
}

float GetRingAlpha(float2 uv, float innerRadius)
{
	float x = (uv.x - 0.5);
	float y = (uv.y - 0.5);
	float r = x*x + y*y;
	float innerRadiusSquare = innerRadius*innerRadius*0.25;

	float border = fwidth(r);
	float alpha = 1;
	if (r > 0.25 || r < innerRadiusSquare) alpha = 0;
	else if (r + border > 0.25) alpha = (0.25 - r) / border;
	else if (r - border < innerRadiusSquare) alpha = (r - innerRadiusSquare) / border;

	return alpha;
}

float GetHexAlpha(float2 uv)
{
	float2x2 m = float2x2(0.57735, -0.28868, 0, 0.5);
	float2 v = mul(float2(uv.x - 0.5, uv.y - 0.5), m);
	float z = -v.x - v.y;
	float r = (abs(v.x) + abs(v.y) + abs(z)) * 0.5;
	float border = fwidth(r);	
	float alpha = 1;

	if (r > 0.25) alpha = 0;
	else if (r + border > 0.25) alpha = (0.25 - r) / border;

	return alpha;
}

float GetHexRingAlpha(float2 uv, float innerRadius)
{
	float2x2 m = float2x2(0.57735, -0.28868, 0, 0.5);
	float2 v = mul(float2(uv.x - 0.5, uv.y - 0.5), m);
	float z = -v.x - v.y;
	float r = (abs(v.x) + abs(v.y) + abs(z)) * 0.5;
	float innerRadiusSquare = innerRadius*innerRadius * 0.25;
	float border = fwidth(r);
	float alpha = 1;

	if (r > 0.25 || r < innerRadiusSquare) alpha = 0;
	else if (r + border > 0.25) alpha = (0.25 - r) / border;
	else if (r - border < innerRadiusSquare) alpha = (r - innerRadiusSquare) / border;

	return alpha;
}

float GetTriAlpha(float2 uv)
{
	float2x2 m = float2x2(0.57735, -0.28868, 0, 0.5);
	float2 v = mul(float2(-uv.y + 0.5, uv.x - 0.5), m);
	float z = -v.x - v.y;
	float r = max(v.x, max(v.y, z))*1.73;
	float alpha = 1;

	float border = fwidth(r);
	if (r > 0.25) alpha = 0;
	else if (r + border > 0.25) alpha = (0.25 - r) / border;

	return alpha;
}

float GetTriRingAlpha(float2 uv, float innerRadius)
{
	float2x2 m = float2x2(0.57735, -0.28868, 0, 0.5);
	float2 v = mul(float2(-uv.y + 0.5, uv.x - 0.5), m);
	float z = -v.x - v.y;
	float r = max(v.x, max(v.y, z))*1.73;
	float innerRadiusSquare = innerRadius*innerRadius * 0.25;
	float border = fwidth(r);
	float alpha = 1;

	if (r > 0.25 || r < innerRadiusSquare) alpha = 0;
	else if (r + border > 0.25) alpha = (0.25 - r) / border;
	else if (r - border < innerRadiusSquare) alpha = (r - innerRadiusSquare) / border;

	return alpha;
}

float GetStarAlpha(float2 uv)
{
	float2x2 m = float2x2(0.57735, -0.28868, 0, 0.5);
	float2 v = mul(float2(-uv.y + 0.5, uv.x - 0.5), m);
	float z = -v.x - v.y;
	float r1 = max(v.x, max(v.y, z))*1.73;
	float r2 = max(-v.x, max(-v.y, -z))*1.73;
	float r = min(r1, r2);
	float border = fwidth(r);
	float alpha = 1;

	if (r > 0.25) alpha = 0;
	else if (r + border > 0.25) alpha = (0.25 - r) / border;

	return alpha;
}

float GetStarRingAlpha(float2 uv, float innerRadius)
{
	float2x2 m = float2x2(0.57735, -0.28868, 0, 0.5);
	float2 v = mul(float2(-uv.y + 0.5, uv.x - 0.5), m);
	float z = -v.x - v.y;
	float r1 = max(v.x, max(v.y, z))*1.73;
	float r2 = max(-v.x, max(-v.y, -z))*1.73;
	float r = min(r1, r2);
	float innerRadiusSquare = innerRadius*innerRadius * 0.25;
	float border = fwidth(r);
	float alpha = 1;

	if (r > 0.25 || r < innerRadiusSquare) alpha = 0;
	else if (r + border > 0.25) alpha = (0.25 - r) / border;
	else if (r - border < innerRadiusSquare) alpha = (r - innerRadiusSquare) / border;

	return alpha;
}

float GetSquareRingAlpha(float2 uv, float innerRadius)
{
	float x = abs(uv.x - 0.5);
	float y = abs(uv.y - 0.5); 
	float r = max(x, y);
	float border = fwidth(r);
	float alpha = 1;
	innerRadius = innerRadius / 2;
	
	if (r > 0.5 || r < innerRadius) alpha = 0;
	else if (r + border > 0.5) alpha = (0.5 - r) / border;
	else if (r - border < innerRadius) alpha = (r - innerRadius) / border;

	return alpha;
}

float GetRoseAlpha(float2 uv, int k)
{
	float x = (uv.x - 0.5);
	float y = (uv.y - 0.5);

	float rSqr = x*x + y*y;
	float theta = atan2(y, x);
	float threshold = sin(k*theta);
	float thresholdSqr = threshold*threshold/4;
	float border = fwidth(x) + fwidth(y);
	float alpha = 1;

	if (rSqr > thresholdSqr) alpha = 0;
	else if (rSqr + border > thresholdSqr) alpha = (thresholdSqr - rSqr) / border;
	return alpha;
}

float GetAsteroidAlpha(float2 uv, int k, float p)
{
	float x = (uv.x - 0.5)*2;
	float y = (uv.y - 0.5)*2;

	float r = sqrt(x*x + y*y);
	float theta = atan2(y, x);
	float t = pow(tan(k*theta), 1/p);
	float threshold = abs(1/cos(k*theta))/pow(1+t, p);
	float thresholdSqr = threshold*threshold;
	float border = fwidth(x) + fwidth(y);
	float alpha = 1;

	if (r > threshold) alpha = 0;
	else if (r + border > threshold) alpha = (threshold - r) / border;
	return alpha;
}

