float rot_x, rot_y, last_rot_x, last_rot_y;
int[][][] cube_color = 
{
  {
    {0, 0, 0}, 
    {0, 0, 0},
    {0, 0, 0}
  },
  {
    {1, 1, 1}, 
    {1, 1, 1},
    {1, 1, 1}
  },
  {
    {2, 2, 2}, 
    {2, 2, 2},
    {2, 2, 2}
  },
  {
    {3, 3, 3}, 
    {3, 3, 3},
    {3, 3, 3}
  },
  {
    {4, 4, 4}, 
    {4, 4, 4},
    {4, 4, 4}
  },
  {
    {5, 5, 5}, 
    {5, 5, 5},
    {5, 5, 5}
  },
};
char matrix_c[][][] = 
{
  {//0
    {0, 0, 0},
    {0, 0, 0},
    {0, 0, 0}
  },
  {//1
    {1, 1, 1},
    {1, 1, 1},
    {1, 1, 1}
  },
  {//2
    {1, 1, 1},
    {0, 0, 0},
    {0, 0, 0}
  },
  {//3
    {0, 0, 0},
    {1, 1, 1},
    {0, 0, 0}
  },
  {//4
    {0, 0, 0},
    {0, 0, 0},
    {1, 1, 1}
  },
  {//5
    {1, 0, 0},
    {1, 0, 0},
    {1, 0, 0}
  },
  {//6
    {0, 1, 0},
    {0, 1, 0},
    {0, 1, 0}
  },
  {//7
    {0, 0, 1},
    {0, 0, 1},
    {0, 0, 1}
  },
};
int matrix_r[][] = 
{
 //w, r, y, o, b, g
  {1, 5, 0, 7, 7, 7},
  {7, 1, 5, 0, 2, 2},
  {0, 7, 1, 5, 5, 5},
  {5, 0, 7, 1, 4, 4},
  {2, 2, 2, 2, 1, 0},
  {4, 4, 4, 4, 0, 1},
};

float rotate_face, rotate_speed = 0.2;
int test_f = 0, last_test_f = -1, f_rotate = -1, last_f_rotate = -1, step_r = 0, cube_case = 0;
int[] step_m = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
boolean key_state = false;
boolean[] k_state = 
{false, false, false, false, false, false, 
 false, false, false, false, false, false};

void set_color_cube (int c)
{
  switch (c)
  {
    case 0: fill (#FFFFFF); break;
    case 1: fill (#F20F0F); break;
    case 2: fill (#F3FF55); break;
    case 3: fill (#FABD23); break;
    case 4: fill (#237EFA); break;
    case 5: fill (#23FA48); break;
  }
  //fill (#FFFFFF);
}

void reset_color ()
{
  for (int i = 0; i < 6; i++)
  {
    for (int j = 0; j < 3; j++)
      for (int k = 0; k < 3; k++)
      {
        cube_color[i][j][k] = i;
      }
  }
}

void draw_cube (int face, float rad, float cam_x, float cam_y)
{
    translate(400, 400, 0);
    rotateX(cam_x);
    rotateY(cam_y);
    for (int n = 0; n < 2; n++)
      for (int i = 0; i < 6; i++)
      {
        switch (i)
        {
          case 0:
          if (n == 0)
          {
            switch (face)
            {
              case 0:
              case 2:
              translate(0, 0, -75);
              rotateZ (rad);
              break;
              case 1:
              case 3:
              translate(-75*sin(rad), 0, -75*cos(rad));
              rotateY (rad);
              break;
              case 4:
              case 5:
              translate(0, 75*sin(rad), -75*cos(rad));
              rotateX (rad);
            }
          }
          if (n == 1)
          {
            switch (face)
            {
              case 0:
              case 2:
              translate(0, 75, -75);
              rotateY (-1.5708);
              rotateX (1.5708);
              rotateZ (-rad);
              break;
              case 1:
              case 3:
              translate(0, 75*cos(rad), -75+75*sin(rad));
              rotateY (-1.5708);
              rotateX (1.5708);
              rotateY (-rad);
              break;
              case 4:
              case 5:
              translate(75*sin(rad), 75*cos(rad), -75);
              rotateY (-1.5708);
              rotateX (1.5708);
              rotateX (-rad);
            }
          }
          break;
          case 1:
          case 2:
          case 3:
          translate(0, 75, 75);
          rotateX (1.5708);
          break;
          case 4:
          translate(-75, 0, 75);
          rotateY (1.5708);
          break;
          case 5:
          translate(0, 0, 150);
          break;
        }
        for (int j = 0; j < 3; j++)
          for (int k = 0; k < 3; k++)
          {
            if (matrix_c[matrix_r[face][i]][j][k] == ((n == 0)? 1 : 0))
            {
              fill (#000000);
              rect(-25+(j-1)*50, -25+(k-1)*50, 50, 50);
              set_color_cube (cube_color[i][j][k]);
              translate(0, 0, (i==5)?0.1 : -0.1);
              rect(-25+(j-1)*50, -25+(k-1)*50, 48, 48, 5);
              //if (k == 0)
              //{
              //  fill (#000000);
              //  text (j, (j-1)*50, (k-1)*50);
              //}
            }
          }
      }
}

int find_center_match (int i, int j, int k)
{
  int match = -1;
  switch (i)
  {
    case 0:
    if (j == 1 && k == 0) match = cube_color[3][1][2];
    else if (j == 1 && k == 2) match = cube_color[1][1][0];
    else if (j == 0 && k == 1) match = cube_color[4][1][2];
    else if (j == 2 && k == 1) match = cube_color[5][1][2];
    break;
    case 1:
    if (j == 1 && k == 0) match = cube_color[0][1][2];
    else if (j == 1 && k == 2) match = cube_color[2][1][0];
    else if (j == 0 && k == 1) match = cube_color[4][0][1];
    else if (j == 2 && k == 1) match = cube_color[5][0][1];
    break;
    case 2:
    if (j == 1 && k == 0) match = cube_color[1][1][2];
    else if (j == 1 && k == 2) match = cube_color[3][1][0];
    else if (j == 0 && k == 1) match = cube_color[4][1][0];
    else if (j == 2 && k == 1) match = cube_color[5][1][0];
    break;
    case 3:
    if (j == 1 && k == 0) match = cube_color[2][1][2];
    else if (j == 1 && k == 2) match = cube_color[0][1][0];
    else if (j == 0 && k == 1) match = cube_color[4][2][1];
    else if (j == 2 && k == 1) match = cube_color[5][2][1];
    break;
    case 4:
    if (j == 1 && k == 0) match = cube_color[3][0][1];
    else if (j == 1 && k == 2) match = cube_color[1][0][1];
    else if (j == 0 && k == 1) match = cube_color[2][0][1];
    else if (j == 2 && k == 1) match = cube_color[0][0][1];
    break;
    case 5:
    if (j == 1 && k == 0) match = cube_color[3][2][1];
    else if (j == 1 && k == 2) match = cube_color[1][2][1];
    else if (j == 0 && k == 1) match = cube_color[0][2][1];
    else if (j == 2 && k == 1) match = cube_color[2][2][1];
    break;
  }
  return match;
}

void auto ()
{
  if (step_r == 0)
  {
    for (int i = 0; i < 6; i++)
      for (int j = 0; j < 3; j++)
        for (int k = 0; k < 3; k++)
        {
          if (cube_color[i][j][k] == 0)
          {
            if (i == 0)
            {
              if (j == 0 && k == 1)
                if (find_center_match(i, j, k) != 4) 
                {
                  cube_case = 0;
                }
              else if (j == 2 && k == 1)
                if (find_center_match(i, j, k) != 5)
                {
                  cube_case = 0;
                }
              else if (j == 1 && k == 0)
                if (find_center_match(i, j, k) != 3) 
                {
                  cube_case = 0;
                }
              else if (j == 1 && k == 2)
                if (find_center_match(i, j, k) != 1) 
                {
                  cube_case = 0;
                }
            }
          }
        }
  }
  f_rotate = step_m[--step_r];
}

void setup ()
{
  size(800, 800, P3D);
  background(204);
    draw_cube (0, 0, 0, 0);
}

void draw ()
{
  if (mousePressed)
  {
    rot_x += (mouseX - pmouseX) / 100.0;
    rot_y += (pmouseY - mouseY) / 100.0;
    //rot_y = constrain (rot_y, -PI, PI);
  }
  int fr = f_rotate % 6;
  if (f_rotate != -1)
  {
    if (f_rotate < 6) rotate_face += rotate_speed;
    else rotate_face -= rotate_speed;
    if (rotate_face >= PI/2 || rotate_face <= -PI/2)
    {
      int[] c_temp = {0, 0, 0};
      int d = ((f_rotate < 6)? 0 : 2);
      int d_inv = ((f_rotate < 6)? 2 : 0);
      if (fr == 1 || fr == 2)
      {
        if (d_inv == 2) d_inv = 0;
        else d_inv = 2;
        if (d == 2) d = 0;
        else d = 2;
      }
      
      c_temp[0] = cube_color[fr][0][d];
      c_temp[1] = cube_color[fr][0][1];
      cube_color[fr][0][d] = cube_color[fr][0][d_inv];
      cube_color[fr][0][1] = cube_color[fr][1][d_inv];
      cube_color[fr][0][d_inv] = cube_color[fr][2][d_inv];
      
      cube_color[fr][1][d_inv] = cube_color[fr][2][1];
      cube_color[fr][2][d_inv] = cube_color[fr][2][d];
      
      cube_color[fr][2][1] = cube_color[fr][1][d];
      cube_color[fr][2][d] = c_temp[0];
      
      cube_color[fr][1][d] = c_temp[1];
      
      for (int i = 0; i < 3; i++)
      {
          switch (f_rotate)
          {
            case 0:
            c_temp[i] = cube_color[1][i][0];
            cube_color[1][i][0] = cube_color[5][i][2];
            cube_color[5][i][2] = cube_color[3][2-i][2];
            cube_color[3][2-i][2] = cube_color[4][2-i][2];
            cube_color[4][2-i][2] = c_temp[i];
            break;
            case 1:
            c_temp[i] = cube_color[4][0][i];
            cube_color[4][0][i] = cube_color[0][i][2];
            cube_color[0][i][2] = cube_color[5][0][2-i];
            cube_color[5][0][2-i] = cube_color[2][2-i][0];
            cube_color[2][2-i][0] = c_temp[i];
            break;
            case 2:
            c_temp[i] = cube_color[3][i][0];
            cube_color[3][i][0] = cube_color[4][i][0];
            cube_color[4][i][0] = cube_color[1][2-i][2];
            cube_color[1][2-i][2] = cube_color[5][2-i][0];
            cube_color[5][2-i][0] = c_temp[i];
            break;
            case 3:
            c_temp[i] = cube_color[0][i][0];
            cube_color[0][i][0] = cube_color[5][2][2-i];
            cube_color[5][2][2-i] = cube_color[2][2-i][2];
            cube_color[2][2-i][2] = cube_color[4][2][i];
            cube_color[4][2][i] = c_temp[i];
            break;
            case 4:
            c_temp[i] = cube_color[3][0][i];
            cube_color[3][0][i] = cube_color[2][0][i];
            cube_color[2][0][i] = cube_color[1][0][i];
            cube_color[1][0][i] = cube_color[0][0][i];
            cube_color[0][0][i] = c_temp[i];
            break;
            case 5:
            c_temp[i] = cube_color[0][2][i];
            cube_color[0][2][i] = cube_color[3][2][i];
            cube_color[3][2][i] = cube_color[2][2][i];
            cube_color[2][2][i] = cube_color[1][2][i];
            cube_color[1][2][i] = c_temp[i];
            break;
            
            case 6:
            c_temp[i] = cube_color[4][i][2];
            cube_color[4][i][2] = cube_color[3][i][2];
            cube_color[3][i][2] = cube_color[5][2-i][2];
            cube_color[5][2-i][2] = cube_color[1][2-i][0];
            cube_color[1][2-i][0] = c_temp[i];
            break;
            case 7:
            c_temp[i] = cube_color[2][i][0];
            cube_color[2][i][0] = cube_color[5][0][i];
            cube_color[5][0][i] = cube_color[0][2-i][2];
            cube_color[0][2-i][2] = cube_color[4][0][2-i];
            cube_color[4][0][2-i] = c_temp[i];
            break;
            case 8:
            c_temp[i] = cube_color[5][i][0];
            cube_color[5][i][0] = cube_color[1][i][2];
            cube_color[1][i][2] = cube_color[4][2-i][0];
            cube_color[4][2-i][0] = cube_color[3][2-i][0];
            cube_color[3][2-i][0] = c_temp[i];
            break;
            case 9:
            c_temp[i] = cube_color[4][2][i];
            cube_color[4][2][i] = cube_color[2][2-i][2];
            cube_color[2][2-i][2] = cube_color[5][2][2-i];
            cube_color[5][2][2-i] = cube_color[0][i][0];
            cube_color[0][i][0] = c_temp[i];
            break;
            case 10:
            c_temp[i] = cube_color[0][0][i];
            cube_color[0][0][i] = cube_color[1][0][i];
            cube_color[1][0][i] = cube_color[2][0][i];
            cube_color[2][0][i] = cube_color[3][0][i];
            cube_color[3][0][i] = c_temp[i];
            break;
            case 11:
            c_temp[i] = cube_color[1][2][i];
            cube_color[1][2][i] = cube_color[2][2][i];
            cube_color[2][2][i] = cube_color[3][2][i];
            cube_color[3][2][i] = cube_color[0][2][i];
            cube_color[0][2][i] = c_temp[i];
            break;
          }
      }
      rotate_face = 0;
      f_rotate = -1;
    }
  }
  background(204);
  draw_cube ((f_rotate == -1)? 0 : fr, rotate_face, rot_y, rot_x);
}

void keyPressed ()
{
  if (f_rotate == -1)
  switch (key)
  {
    case 'w': 
    f_rotate = 0;
    break;
    case 'r': 
    f_rotate = 1;
    break;
    case 'y': 
    f_rotate = 2;
    break;
    case 'o': 
    f_rotate = 3;
    break;
    case 'b': 
    f_rotate = 4;
    break;
    case 'g': 
    f_rotate = 5;
    break;
    case 'W': 
    f_rotate = 6;
    break;
    case 'R': 
    f_rotate = 7;
    break;
    case 'Y': 
    f_rotate = 8;
    break;
    case 'O': 
    f_rotate = 9;
    break;
    case 'B': 
    f_rotate = 10;
    break;
    case 'G': 
    f_rotate = 11;
    break;
    //case '7': 
    //f_rotate = 12;
    //break;
    //case '8': 
    //f_rotate = 13;
    //break;
    //case '9': 
    //f_rotate = 14;
    //break;
    //case 'u': 
    //f_rotate = 15;
    //break;
    //case 'i': 
    //f_rotate = 16;
    //break;
    //case 'o': 
    //f_rotate = 17;
    //break;
  }
  if (key == ' ')
  {
    if (!key_state)
    {
      key_state = true;
      reset_color ();
    }
  }
}

void keyReleased ()
{
  if (key == ' ')
  {
    if (key_state)
    {
      key_state = false;
    }
  }
}
