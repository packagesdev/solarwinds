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

// Solar Winds screen saver

#include "SolarWinds.h"

#include <stdlib.h>
#include <math.h>
#include <time.h>

#include <OpenGL/gl.h>
#include <OpenGL/glu.h>

#define PIx2 6.28318530718f


// Useful random number macro
// Don't forget to initialize with srand()
#define myRandf(x) ((rand() * x )/(((double) 1.0)*RAND_MAX))

scene::scene()
{
	srand((unsigned)time(NULL));
	rand(); rand(); rand(); rand(); rand();
}

scene::~scene()
{
	if (glIsList(1))
		glDeleteLists(1,1);
	
	if (winds!=NULL)
	{
		delete[] winds;
		
		winds=NULL;
	}
}

#pragma mark -

void scene::resize(int inWidth,int inHeight)
{
	// Window initialization
	
	glViewport(0,0, inWidth, inHeight);
	
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	gluPerspective(90.0, float(inWidth) / float(inHeight), 1.0, 10000);
	
	glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);
}

void scene::create()
{
	if(!geometryType)
		glBlendFunc(GL_ONE, GL_ONE);
	else
		glBlendFunc(GL_SRC_ALPHA, GL_ONE);  // Necessary for point and line smoothing (I don't know why)
	
	glEnable(GL_BLEND);
	
	if (glIsTexture(1))
	{
		GLuint tTex=1;
		
		glDeleteTextures(1, &tTex);
	}
	
	if(!geometryType)
	{
		float x,x2, y, temp;
		
		// Init lights
		
		for(int i=0; i<LIGHTSIZE; i++)
		{
			x = float(i - LIGHTSIZE / 2) / float(LIGHTSIZE / 2);
			
			x2=x*x;
			
			for(int j=0; j<LIGHTSIZE; j++)
			{
				y = float(j - LIGHTSIZE / 2) / float(LIGHTSIZE / 2);
				
				temp = 1.0f - float(sqrt(x2 + (y * y)));
				
				if(temp > 1.0f)
				{
					temp = 1.0f;
				}
				else
				{
					if(temp < 0.0f)
						temp = 0.0f;
				}
				
				lightTexture[i][j] = (unsigned char) (255.0f * temp);
			}
		}
		
		glEnable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, 1);
		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
		glTexImage2D(GL_TEXTURE_2D, 0, 1, LIGHTSIZE, LIGHTSIZE, 0,
					 GL_LUMINANCE, GL_UNSIGNED_BYTE, lightTexture);
		temp = 0.02f * float(particleSize);
		glNewList(1, GL_COMPILE);
		glBindTexture(GL_TEXTURE_2D, 1);
		glBegin(GL_TRIANGLE_STRIP);
		glTexCoord2f(0.0f, 0.0f);
		glVertex3f(-temp, -temp, 0.0f);
		glTexCoord2f(1.0f, 0.0f);
		glVertex3f(temp, -temp, 0.0f);
		glTexCoord2f(0.0f, 1.0f);
		glVertex3f(-temp, temp, 0.0f);
		glTexCoord2f(1.0f, 1.0f);
		glVertex3f(temp, temp, 0.0f);
		glEnd();
		
		glEndList();
	}
	else
	{
		glDisable(GL_TEXTURE_2D);
		glBindTexture(GL_TEXTURE_2D, 0);
		
		if(geometryType == 1)
		{  // init point smoothing
			glEnable(GL_POINT_SMOOTH);
			glHint(GL_POINT_SMOOTH_HINT, GL_NICEST);
		}
		else
		{
			if(geometryType == 2)
			{  // init line smoothing
				glEnable(GL_LINE_SMOOTH);
				glHint(GL_LINE_SMOOTH_HINT, GL_NICEST);
			}
		}
	}
	
	// Initialize surfaces
	
	winds = new wind[windsCount];
	
	for(int i=0; i<windsCount; i++)
		winds[i].initWithScene(this);
}

void scene::draw()
{
	//glLoadIdentity();
	
	if(!geometryType)
	{
		glBindTexture(GL_TEXTURE_2D, 0);
	}
	
	if(!motionBlur)
	{
		glClear(GL_COLOR_BUFFER_BIT);
	}
	else
	{
		glMatrixMode(GL_PROJECTION);
		glPushMatrix();
		glLoadIdentity();
		glOrtho(0.0, 1.0, 0.0, 1.0, 1.0, -1.0);
		glMatrixMode(GL_MODELVIEW);
		glLoadIdentity();
		glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
		glColor4f(0.0f, 0.0f, 0.0f, 0.5f - (float(motionBlur) * 0.0049f));
		glBegin(GL_TRIANGLE_STRIP);
		glVertex3f(0.0f, 0.0f, 0.0f);
		glVertex3f(1.0f, 0.0f, 0.0f);
		glVertex3f(0.0f, 1.0f, 0.0f);
		glVertex3f(1.0f, 1.0f, 0.0f);
		glEnd();
		
		if(!geometryType)
			glBlendFunc(GL_ONE, GL_ONE);
		else
			glBlendFunc(GL_SRC_ALPHA, GL_ONE);  // Necessary for point and line smoothing (I don't know why)
		// Maybe it's just my video card...
		glMatrixMode(GL_PROJECTION);
		glPopMatrix();
	}
	
	glMatrixMode(GL_MODELVIEW);
	glLoadIdentity();
	glTranslatef(0.0, 0.0, -15.0);
	
	// You should need to draw twice if using blur, once to each buffer.
	// But wglSwapLayerBuffers appears to copy the back to the
	// front instead of just switching the pointers to them.  It turns
	// out that both NVidia and 3dfx prefer to use PFD_SWAP_COPY instead
	// of PFD_SWAP_EXCHANGE in the PIXELFORMATDESCRIPTOR.  I don't know why...
	// So this may not work right on other platforms or all video cards.
	
	// Update surfaces
	for(int i=0; i<windsCount; i++)
		winds[i].updateWithScene(this);
}

#pragma mark -

wind::wind()
{
	whichparticle = 0;
}

wind::~wind()
{
    int i;

    for(i=0; i<dEmitters; i++)
            delete[] emitters[i];
    delete[] emitters;

    for(i=0; i<dParticles; i++)
            delete[] particles[i];
    delete[] particles;

    if(dGeometry == 2)
    {
        for(i=0; i<dParticles; i++)
            delete[] linelist[i];
        
        delete[] linelist;
        delete[] lastparticle;
    }
}

void wind::initWithScene(scene *inScene)
{
	dEmitters=inScene->emittersCount;
	dGeometry=inScene->geometryType;
	dParticles=inScene->particlesCount;
	
	emitters = new float*[dEmitters];
	
	for(int i=0; i<dEmitters; i++)
	{
		emitters[i] = new float[3];
		
		emitters[i][0] = myRandf(60.0f) - 30.0f;
		emitters[i][1] = myRandf(60.0f) - 30.0f;
		emitters[i][2] = myRandf(30.0f) - 15.0f;
	}
	
	particles = new float*[dParticles];
	
	for(int i=0; i<dParticles; i++)
	{
		particles[i] = new float[6];  // 3 for pos, 3 for color
		particles[i][2] = 100.0f;  // start particles behind viewer
	}
	
	
	
	if(dGeometry == 2)
	{
		// allocate memory for lines
		
		linelist = new int*[dParticles];
		
		for(int i=0; i<dParticles; i++)
		{
			linelist[i] = new int[2];
			
			linelist[i][0] = -1;
			linelist[i][1] = -1;
		}
		
		lastparticle = new int[dEmitters];
		
		for(int i=0; i<dEmitters; i++)
			lastparticle[i] = i;
	}
	
	for(int i=0; i<NUMCONSTS; i++)
	{
		ct[i] = myRandf(PIx2);
		cv[i] = myRandf(0.00005f * float(inScene->windSpeed) * float(inScene->windSpeed))
		+ 0.00001f * float(inScene->windSpeed) * float(inScene->windSpeed);
	}
}

void wind::updateWithScene(scene * inScene)
{
    int i;
    float x, y, z;
    float temp;
    float evel = float(inScene->emitterSpeed) * 0.01f;
    float pvel = float(inScene->particleSpeed) * 0.01f;
    float pointsize = 0.04f * float(inScene->particleSize);
    float linesize = 0.005f * float(inScene->particleSize);

    // update constants
    for(i=0; i<NUMCONSTS; i++)
    {
        ct[i] += cv[i];
        
        if(ct[i] > PIx2)
            ct[i] -= PIx2;
            c[i] = cos(ct[i]);
    }
    
    // calculate emissions
    for(i=0; i<dEmitters; i++)
    {
        emitters[i][2] += evel;  // emitter moves toward viewer
        
        if(emitters[i][2] > 15.0f)
        {
            // reset emitter
            
            emitters[i][0] = myRandf(60.0f) - 30.0f;
            emitters[i][1] = myRandf(60.0f) - 30.0f;
            emitters[i][2] = -15.0f;
        }
        
        particles[whichparticle][0] = emitters[i][0];
        particles[whichparticle][1] = emitters[i][1];
        particles[whichparticle][2] = emitters[i][2];
        
        if(dGeometry == 2)
        {
            // link particles to form lines
            
            if(linelist[whichparticle][0] >= 0)
                linelist[linelist[whichparticle][0]][1] = -1;
            
            linelist[whichparticle][0] = -1;
            
            if(emitters[i][2] == -15.0f)
                linelist[whichparticle][1] = -1;
            else
                linelist[whichparticle][1] = lastparticle[i];
            
            linelist[lastparticle[i]][0] = whichparticle;
            lastparticle[i] = whichparticle;
        }
        
        whichparticle++;
        if(whichparticle >= dParticles)
            whichparticle = 0;
    }

    // calculate particle positions and colors
    // first modify constants that affect colors
    c[6] *= 9.0f / float(inScene->particleSpeed);
    c[7] *= 9.0f / float(inScene->particleSpeed);
    c[8] *= 9.0f / float(inScene->particleSpeed);

    // then update each particle

    for(i=0; i<dParticles; i++)
    {
        // store old positions
        x = particles[i][0];
        y = particles[i][1];
        z = particles[i][2];
        // make new positions
        particles[i][0] = x + (c[0] * y + c[1] * z) * pvel;
        particles[i][1] = y + (c[2] * z + c[3] * x) * pvel;
        particles[i][2] = z + (c[4] * x + c[5] * y) * pvel;
        // calculate colors
        particles[i][3] = (float) fabs((particles[i][0] - x) * c[6]);
        particles[i][4] = (float) fabs((particles[i][1] - y) * c[7]);
        particles[i][5] = (float) fabs((particles[i][2] - z) * c[8]);
        // clamp colors
        if(particles[i][3] > 1.0f)
                particles[i][3] = 1.0f;
        if(particles[i][4] > 1.0f)
                particles[i][4] = 1.0f;
        if(particles[i][5] > 1.0f)
                particles[i][5] = 1.0f;
    }

    // draw particles
    
    switch(dGeometry)
    {
	case 0:  // lights
            for(i=0; i<dParticles; i++)
            {
                glColor3fv(&particles[i][3]);
                glPushMatrix();
                    glTranslatef(particles[i][0], particles[i][1], particles[i][2]);
                    glCallList(1);
                glPopMatrix();
            }
            break;
	case 1:  // points
            for(i=0; i<dParticles; i++)
            {
                temp = particles[i][2] + 40.0f;
                
                if(temp < 0.01f)
                    temp = 0.01f;
                
                glPointSize(pointsize * temp);
                glBegin(GL_POINTS);
                    glColor3fv(&particles[i][3]);
                    glVertex3fv(particles[i]);
                glEnd();
            }
            break;
	case 2:  // lines
            for(i=0; i<dParticles; i++)
            {
                temp = particles[i][2] + 40.0f;
                if(temp < 0.01f)
                    temp = 0.01f;
                
                glLineWidth(linesize * temp);
                glBegin(GL_LINES);
                    if(linelist[i][1] >= 0)
                    {
                        glColor3fv(&particles[i][3]);
                        
                        if(linelist[i][0] == -1)
                                glColor3f(0.0f, 0.0f, 0.0f);
                        
                        glVertex3fv(particles[i]);
                        glColor3fv(&particles[linelist[i][1]][3]);
                        
                        if(linelist[linelist[i][1]][1] == -1)
                                glColor3f(0.0f, 0.0f, 0.0f);
                        
                        glVertex3fv(particles[linelist[i][1]]);
                    }
                glEnd();
            }
    }
}