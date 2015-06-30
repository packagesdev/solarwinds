/*
 * Copyright (C) 2002-2015  Terence M. Welsh
 *
 * Solar Winds is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * Solar Winds is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

/* Modified by Stephane Sudre so that there is a scene class */

#ifndef __SOLARWINDS__
#define __SOLARWINDS__

#define DEG2RAD 0.0174532925f
#define LIGHTSIZE 64
#define NUMCONSTS 9

class wind;

class scene
{
	public:
		
		int windsCount;
		wind *winds;
		
		int emittersCount;
		int particlesCount;
		int geometryType;
		int particleSize;
		int particleSpeed;
		int emitterSpeed;
		int windSpeed;
		int motionBlur;
		
		unsigned char lightTexture[LIGHTSIZE][LIGHTSIZE];
	
		scene();
		virtual ~scene();
	
		void create();
		void resize(int inWidth,int inHeight);
		void draw();
};

class wind
{
    public:
    
        int dParticles;
        int dGeometry;
        int dEmitters;
        
        float **emitters;
        float **particles;
        int **linelist;
        int *lastparticle;
        int whichparticle;
        float c[NUMCONSTS];
        float ct[NUMCONSTS];
        float cv[NUMCONSTS];
    
        wind();
        virtual ~wind();
	
		void initWithScene(scene *inScene);
        void updateWithScene(scene * inScene);
};

#endif