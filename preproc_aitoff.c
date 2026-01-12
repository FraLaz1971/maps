#include <stdio.h>
#include <math.h>

#define PI 3.14159265358979323846

float ra_shift(float h) {
    return (h > 180) ? h - 360 : h;
}

// In C, sin/cos ALWAYS take radians. 
// We must convert our Degree inputs to Radians first.
float alpha(float lam_deg, float phi_deg) {
    float lam = lam_deg * PI / 180.0;
    float phi = phi_deg * PI / 180.0;
    return acos(cos(phi) * cos(lam / 2.0)); // Result is in Radians
}

float sinc(float a_rad) {
    return (a_rad == 0) ? 1.0 : sin(a_rad) / a_rad;
}

float aitoff_x(float lam_deg, float phi_deg) {
    float phi_rad = phi_deg * PI / 180.0;
    float lam_rad = lam_deg * PI / 180.0;
    float a = alpha(lam_deg, phi_deg);
    return (2.0 * cos(phi_rad) * sin(lam_rad / 2.0)) / sinc(a);
}

float aitoff_y(float lam_deg, float phi_deg) {
    float phi_rad = phi_deg * PI / 180.0;
    float a = alpha(lam_deg, phi_deg);
    return sin(phi_rad) / sinc(a);
}
int main(int argc, char **argv){
  int i,ret;
  float ra,dec,mag;
  for (i=0;i<100;i++){
	ret = scanf("%f %f %f\n",&ra,&dec,&mag);
	printf("%f %f %f\n",aitoff_x(ra_shift(ra), dec),aitoff_y(ra_shift(ra), dec),mag);
  }
  return 0;
}

// (aitoff_x(ra_shift($1), $2)):(aitoff_y(ra_shift($1), $2))
