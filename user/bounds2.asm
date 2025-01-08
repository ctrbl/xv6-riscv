
user/_bounds2:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <main>:
   exit(0); \
}

int
main(int argc, char *argv[])
{
    3000:	7179                	addi	sp,sp,-48
    3002:	f406                	sd	ra,40(sp)
    3004:	f022                	sd	s0,32(sp)
    3006:	ec26                	sd	s1,24(sp)
    3008:	e84a                	sd	s2,16(sp)
    300a:	1800                	addi	s0,sp,48
  char *arg;

  // ensure stack is actually high... This is in the last user accessible page
  assert((uint64) &arg > 639*1024);
    300c:	fd840713          	addi	a4,s0,-40
    3010:	000a07b7          	lui	a5,0xa0
    3014:	c0078793          	addi	a5,a5,-1024 # 9fc00 <base+0x9bbf0>
    3018:	04e7e863          	bltu	a5,a4,3068 <main+0x68>
    301c:	465d                	li	a2,23
    301e:	00001597          	auipc	a1,0x1
    3022:	c5258593          	addi	a1,a1,-942 # 3c70 <malloc+0xf2>
    3026:	00001517          	auipc	a0,0x1
    302a:	c5a50513          	addi	a0,a0,-934 # 3c80 <malloc+0x102>
    302e:	00001097          	auipc	ra,0x1
    3032:	a92080e7          	jalr	-1390(ra) # 3ac0 <printf>
    3036:	00001597          	auipc	a1,0x1
    303a:	c5258593          	addi	a1,a1,-942 # 3c88 <malloc+0x10a>
    303e:	00001517          	auipc	a0,0x1
    3042:	c6a50513          	addi	a0,a0,-918 # 3ca8 <malloc+0x12a>
    3046:	00001097          	auipc	ra,0x1
    304a:	a7a080e7          	jalr	-1414(ra) # 3ac0 <printf>
    304e:	00001517          	auipc	a0,0x1
    3052:	c7250513          	addi	a0,a0,-910 # 3cc0 <malloc+0x142>
    3056:	00001097          	auipc	ra,0x1
    305a:	a6a080e7          	jalr	-1430(ra) # 3ac0 <printf>
    305e:	4501                	li	a0,0
    3060:	00000097          	auipc	ra,0x0
    3064:	6b8080e7          	jalr	1720(ra) # 3718 <exit>

  int fd = open("tmp", O_WRONLY|O_CREATE);
    3068:	20100593          	li	a1,513
    306c:	00001517          	auipc	a0,0x1
    3070:	c6450513          	addi	a0,a0,-924 # 3cd0 <malloc+0x152>
    3074:	00000097          	auipc	ra,0x0
    3078:	6ec080e7          	jalr	1772(ra) # 3760 <open>
    307c:	84aa                	mv	s1,a0
  assert(fd != -1);
    307e:	57fd                	li	a5,-1
    3080:	06f50f63          	beq	a0,a5,30fe <main+0xfe>

  /* grow the heap a bit (move sz around) */
  assert((uint64)sbrk(4096 * 60) != -1);
    3084:	0003c537          	lui	a0,0x3c
    3088:	00000097          	auipc	ra,0x0
    308c:	720080e7          	jalr	1824(ra) # 37a8 <sbrk>
    3090:	57fd                	li	a5,-1
    3092:	0af50c63          	beq	a0,a5,314a <main+0x14a>

  /* below code */
  arg = (char*) 0xfff;
    3096:	6585                	lui	a1,0x1
    3098:	15fd                	addi	a1,a1,-1
    309a:	fcb43c23          	sd	a1,-40(s0)
  assert(write(fd, arg, 1) == -1);
    309e:	4605                	li	a2,1
    30a0:	8526                	mv	a0,s1
    30a2:	00000097          	auipc	ra,0x0
    30a6:	69e080e7          	jalr	1694(ra) # 3740 <write>
    30aa:	57fd                	li	a5,-1
    30ac:	0ef50563          	beq	a0,a5,3196 <main+0x196>
    30b0:	02100613          	li	a2,33
    30b4:	00001597          	auipc	a1,0x1
    30b8:	bbc58593          	addi	a1,a1,-1092 # 3c70 <malloc+0xf2>
    30bc:	00001517          	auipc	a0,0x1
    30c0:	bc450513          	addi	a0,a0,-1084 # 3c80 <malloc+0x102>
    30c4:	00001097          	auipc	ra,0x1
    30c8:	9fc080e7          	jalr	-1540(ra) # 3ac0 <printf>
    30cc:	00001597          	auipc	a1,0x1
    30d0:	c3c58593          	addi	a1,a1,-964 # 3d08 <malloc+0x18a>
    30d4:	00001517          	auipc	a0,0x1
    30d8:	bd450513          	addi	a0,a0,-1068 # 3ca8 <malloc+0x12a>
    30dc:	00001097          	auipc	ra,0x1
    30e0:	9e4080e7          	jalr	-1564(ra) # 3ac0 <printf>
    30e4:	00001517          	auipc	a0,0x1
    30e8:	bdc50513          	addi	a0,a0,-1060 # 3cc0 <malloc+0x142>
    30ec:	00001097          	auipc	ra,0x1
    30f0:	9d4080e7          	jalr	-1580(ra) # 3ac0 <printf>
    30f4:	4501                	li	a0,0
    30f6:	00000097          	auipc	ra,0x0
    30fa:	622080e7          	jalr	1570(ra) # 3718 <exit>
  assert(fd != -1);
    30fe:	4669                	li	a2,26
    3100:	00001597          	auipc	a1,0x1
    3104:	b7058593          	addi	a1,a1,-1168 # 3c70 <malloc+0xf2>
    3108:	00001517          	auipc	a0,0x1
    310c:	b7850513          	addi	a0,a0,-1160 # 3c80 <malloc+0x102>
    3110:	00001097          	auipc	ra,0x1
    3114:	9b0080e7          	jalr	-1616(ra) # 3ac0 <printf>
    3118:	00001597          	auipc	a1,0x1
    311c:	bc058593          	addi	a1,a1,-1088 # 3cd8 <malloc+0x15a>
    3120:	00001517          	auipc	a0,0x1
    3124:	b8850513          	addi	a0,a0,-1144 # 3ca8 <malloc+0x12a>
    3128:	00001097          	auipc	ra,0x1
    312c:	998080e7          	jalr	-1640(ra) # 3ac0 <printf>
    3130:	00001517          	auipc	a0,0x1
    3134:	b9050513          	addi	a0,a0,-1136 # 3cc0 <malloc+0x142>
    3138:	00001097          	auipc	ra,0x1
    313c:	988080e7          	jalr	-1656(ra) # 3ac0 <printf>
    3140:	4501                	li	a0,0
    3142:	00000097          	auipc	ra,0x0
    3146:	5d6080e7          	jalr	1494(ra) # 3718 <exit>
  assert((uint64)sbrk(4096 * 60) != -1);
    314a:	4675                	li	a2,29
    314c:	00001597          	auipc	a1,0x1
    3150:	b2458593          	addi	a1,a1,-1244 # 3c70 <malloc+0xf2>
    3154:	00001517          	auipc	a0,0x1
    3158:	b2c50513          	addi	a0,a0,-1236 # 3c80 <malloc+0x102>
    315c:	00001097          	auipc	ra,0x1
    3160:	964080e7          	jalr	-1692(ra) # 3ac0 <printf>
    3164:	00001597          	auipc	a1,0x1
    3168:	b8458593          	addi	a1,a1,-1148 # 3ce8 <malloc+0x16a>
    316c:	00001517          	auipc	a0,0x1
    3170:	b3c50513          	addi	a0,a0,-1220 # 3ca8 <malloc+0x12a>
    3174:	00001097          	auipc	ra,0x1
    3178:	94c080e7          	jalr	-1716(ra) # 3ac0 <printf>
    317c:	00001517          	auipc	a0,0x1
    3180:	b4450513          	addi	a0,a0,-1212 # 3cc0 <malloc+0x142>
    3184:	00001097          	auipc	ra,0x1
    3188:	93c080e7          	jalr	-1732(ra) # 3ac0 <printf>
    318c:	4501                	li	a0,0
    318e:	00000097          	auipc	ra,0x0
    3192:	58a080e7          	jalr	1418(ra) # 3718 <exit>

  /* spanning code bottom */
  assert(write(fd, arg, 2) == -1);
    3196:	4609                	li	a2,2
    3198:	6585                	lui	a1,0x1
    319a:	15fd                	addi	a1,a1,-1
    319c:	8526                	mv	a0,s1
    319e:	00000097          	auipc	ra,0x0
    31a2:	5a2080e7          	jalr	1442(ra) # 3740 <write>
    31a6:	57fd                	li	a5,-1
    31a8:	04f50963          	beq	a0,a5,31fa <main+0x1fa>
    31ac:	02400613          	li	a2,36
    31b0:	00001597          	auipc	a1,0x1
    31b4:	ac058593          	addi	a1,a1,-1344 # 3c70 <malloc+0xf2>
    31b8:	00001517          	auipc	a0,0x1
    31bc:	ac850513          	addi	a0,a0,-1336 # 3c80 <malloc+0x102>
    31c0:	00001097          	auipc	ra,0x1
    31c4:	900080e7          	jalr	-1792(ra) # 3ac0 <printf>
    31c8:	00001597          	auipc	a1,0x1
    31cc:	b5858593          	addi	a1,a1,-1192 # 3d20 <malloc+0x1a2>
    31d0:	00001517          	auipc	a0,0x1
    31d4:	ad850513          	addi	a0,a0,-1320 # 3ca8 <malloc+0x12a>
    31d8:	00001097          	auipc	ra,0x1
    31dc:	8e8080e7          	jalr	-1816(ra) # 3ac0 <printf>
    31e0:	00001517          	auipc	a0,0x1
    31e4:	ae050513          	addi	a0,a0,-1312 # 3cc0 <malloc+0x142>
    31e8:	00001097          	auipc	ra,0x1
    31ec:	8d8080e7          	jalr	-1832(ra) # 3ac0 <printf>
    31f0:	4501                	li	a0,0
    31f2:	00000097          	auipc	ra,0x0
    31f6:	526080e7          	jalr	1318(ra) # 3718 <exit>

  /* at code */
  arg = (char*) 0x3000;
    31fa:	678d                	lui	a5,0x3
    31fc:	fcf43c23          	sd	a5,-40(s0)
  assert(write(fd, arg, 1) != -1);
    3200:	4605                	li	a2,1
    3202:	658d                	lui	a1,0x3
    3204:	8526                	mv	a0,s1
    3206:	00000097          	auipc	ra,0x0
    320a:	53a080e7          	jalr	1338(ra) # 3740 <write>
    320e:	57fd                	li	a5,-1
    3210:	0af50a63          	beq	a0,a5,32c4 <main+0x2c4>

  /* within code/heap */
  arg = (char*) (((uint64)sbrk(0) - 4096) / 2);
    3214:	4501                	li	a0,0
    3216:	00000097          	auipc	ra,0x0
    321a:	592080e7          	jalr	1426(ra) # 37a8 <sbrk>
    321e:	75fd                	lui	a1,0xfffff
    3220:	95aa                	add	a1,a1,a0
    3222:	8185                	srli	a1,a1,0x1
    3224:	fcb43c23          	sd	a1,-40(s0)
  assert(write(fd, arg, 40) != -1);
    3228:	02800613          	li	a2,40
    322c:	8526                	mv	a0,s1
    322e:	00000097          	auipc	ra,0x0
    3232:	512080e7          	jalr	1298(ra) # 3740 <write>
    3236:	57fd                	li	a5,-1
    3238:	0cf50d63          	beq	a0,a5,3312 <main+0x312>

  /* at heap top */
  arg = (char*) ((uint64)sbrk(0)-1);
    323c:	4501                	li	a0,0
    323e:	00000097          	auipc	ra,0x0
    3242:	56a080e7          	jalr	1386(ra) # 37a8 <sbrk>
    3246:	fff50913          	addi	s2,a0,-1
    324a:	fd243c23          	sd	s2,-40(s0)
  assert(write(fd, arg, 1) != -1);
    324e:	4605                	li	a2,1
    3250:	85ca                	mv	a1,s2
    3252:	8526                	mv	a0,s1
    3254:	00000097          	auipc	ra,0x0
    3258:	4ec080e7          	jalr	1260(ra) # 3740 <write>
    325c:	57fd                	li	a5,-1
    325e:	10f50163          	beq	a0,a5,3360 <main+0x360>

  /* spanning heap top */
  assert(write(fd, arg, 2) == -1);
    3262:	4609                	li	a2,2
    3264:	85ca                	mv	a1,s2
    3266:	8526                	mv	a0,s1
    3268:	00000097          	auipc	ra,0x0
    326c:	4d8080e7          	jalr	1240(ra) # 3740 <write>
    3270:	57fd                	li	a5,-1
    3272:	12f50e63          	beq	a0,a5,33ae <main+0x3ae>
    3276:	03300613          	li	a2,51
    327a:	00001597          	auipc	a1,0x1
    327e:	9f658593          	addi	a1,a1,-1546 # 3c70 <malloc+0xf2>
    3282:	00001517          	auipc	a0,0x1
    3286:	9fe50513          	addi	a0,a0,-1538 # 3c80 <malloc+0x102>
    328a:	00001097          	auipc	ra,0x1
    328e:	836080e7          	jalr	-1994(ra) # 3ac0 <printf>
    3292:	00001597          	auipc	a1,0x1
    3296:	a8e58593          	addi	a1,a1,-1394 # 3d20 <malloc+0x1a2>
    329a:	00001517          	auipc	a0,0x1
    329e:	a0e50513          	addi	a0,a0,-1522 # 3ca8 <malloc+0x12a>
    32a2:	00001097          	auipc	ra,0x1
    32a6:	81e080e7          	jalr	-2018(ra) # 3ac0 <printf>
    32aa:	00001517          	auipc	a0,0x1
    32ae:	a1650513          	addi	a0,a0,-1514 # 3cc0 <malloc+0x142>
    32b2:	00001097          	auipc	ra,0x1
    32b6:	80e080e7          	jalr	-2034(ra) # 3ac0 <printf>
    32ba:	4501                	li	a0,0
    32bc:	00000097          	auipc	ra,0x0
    32c0:	45c080e7          	jalr	1116(ra) # 3718 <exit>
  assert(write(fd, arg, 1) != -1);
    32c4:	02800613          	li	a2,40
    32c8:	00001597          	auipc	a1,0x1
    32cc:	9a858593          	addi	a1,a1,-1624 # 3c70 <malloc+0xf2>
    32d0:	00001517          	auipc	a0,0x1
    32d4:	9b050513          	addi	a0,a0,-1616 # 3c80 <malloc+0x102>
    32d8:	00000097          	auipc	ra,0x0
    32dc:	7e8080e7          	jalr	2024(ra) # 3ac0 <printf>
    32e0:	00001597          	auipc	a1,0x1
    32e4:	a5858593          	addi	a1,a1,-1448 # 3d38 <malloc+0x1ba>
    32e8:	00001517          	auipc	a0,0x1
    32ec:	9c050513          	addi	a0,a0,-1600 # 3ca8 <malloc+0x12a>
    32f0:	00000097          	auipc	ra,0x0
    32f4:	7d0080e7          	jalr	2000(ra) # 3ac0 <printf>
    32f8:	00001517          	auipc	a0,0x1
    32fc:	9c850513          	addi	a0,a0,-1592 # 3cc0 <malloc+0x142>
    3300:	00000097          	auipc	ra,0x0
    3304:	7c0080e7          	jalr	1984(ra) # 3ac0 <printf>
    3308:	4501                	li	a0,0
    330a:	00000097          	auipc	ra,0x0
    330e:	40e080e7          	jalr	1038(ra) # 3718 <exit>
  assert(write(fd, arg, 40) != -1);
    3312:	02c00613          	li	a2,44
    3316:	00001597          	auipc	a1,0x1
    331a:	95a58593          	addi	a1,a1,-1702 # 3c70 <malloc+0xf2>
    331e:	00001517          	auipc	a0,0x1
    3322:	96250513          	addi	a0,a0,-1694 # 3c80 <malloc+0x102>
    3326:	00000097          	auipc	ra,0x0
    332a:	79a080e7          	jalr	1946(ra) # 3ac0 <printf>
    332e:	00001597          	auipc	a1,0x1
    3332:	a2258593          	addi	a1,a1,-1502 # 3d50 <malloc+0x1d2>
    3336:	00001517          	auipc	a0,0x1
    333a:	97250513          	addi	a0,a0,-1678 # 3ca8 <malloc+0x12a>
    333e:	00000097          	auipc	ra,0x0
    3342:	782080e7          	jalr	1922(ra) # 3ac0 <printf>
    3346:	00001517          	auipc	a0,0x1
    334a:	97a50513          	addi	a0,a0,-1670 # 3cc0 <malloc+0x142>
    334e:	00000097          	auipc	ra,0x0
    3352:	772080e7          	jalr	1906(ra) # 3ac0 <printf>
    3356:	4501                	li	a0,0
    3358:	00000097          	auipc	ra,0x0
    335c:	3c0080e7          	jalr	960(ra) # 3718 <exit>
  assert(write(fd, arg, 1) != -1);
    3360:	03000613          	li	a2,48
    3364:	00001597          	auipc	a1,0x1
    3368:	90c58593          	addi	a1,a1,-1780 # 3c70 <malloc+0xf2>
    336c:	00001517          	auipc	a0,0x1
    3370:	91450513          	addi	a0,a0,-1772 # 3c80 <malloc+0x102>
    3374:	00000097          	auipc	ra,0x0
    3378:	74c080e7          	jalr	1868(ra) # 3ac0 <printf>
    337c:	00001597          	auipc	a1,0x1
    3380:	9bc58593          	addi	a1,a1,-1604 # 3d38 <malloc+0x1ba>
    3384:	00001517          	auipc	a0,0x1
    3388:	92450513          	addi	a0,a0,-1756 # 3ca8 <malloc+0x12a>
    338c:	00000097          	auipc	ra,0x0
    3390:	734080e7          	jalr	1844(ra) # 3ac0 <printf>
    3394:	00001517          	auipc	a0,0x1
    3398:	92c50513          	addi	a0,a0,-1748 # 3cc0 <malloc+0x142>
    339c:	00000097          	auipc	ra,0x0
    33a0:	724080e7          	jalr	1828(ra) # 3ac0 <printf>
    33a4:	4501                	li	a0,0
    33a6:	00000097          	auipc	ra,0x0
    33aa:	372080e7          	jalr	882(ra) # 3718 <exit>

  /* above heap top */
  arg = (char*) sbrk(0);
    33ae:	4501                	li	a0,0
    33b0:	00000097          	auipc	ra,0x0
    33b4:	3f8080e7          	jalr	1016(ra) # 37a8 <sbrk>
    33b8:	85aa                	mv	a1,a0
    33ba:	fca43c23          	sd	a0,-40(s0)
  assert(write(fd, arg, 1) == -1);
    33be:	4605                	li	a2,1
    33c0:	8526                	mv	a0,s1
    33c2:	00000097          	auipc	ra,0x0
    33c6:	37e080e7          	jalr	894(ra) # 3740 <write>
    33ca:	57fd                	li	a5,-1
    33cc:	04f50963          	beq	a0,a5,341e <main+0x41e>
    33d0:	03700613          	li	a2,55
    33d4:	00001597          	auipc	a1,0x1
    33d8:	89c58593          	addi	a1,a1,-1892 # 3c70 <malloc+0xf2>
    33dc:	00001517          	auipc	a0,0x1
    33e0:	8a450513          	addi	a0,a0,-1884 # 3c80 <malloc+0x102>
    33e4:	00000097          	auipc	ra,0x0
    33e8:	6dc080e7          	jalr	1756(ra) # 3ac0 <printf>
    33ec:	00001597          	auipc	a1,0x1
    33f0:	91c58593          	addi	a1,a1,-1764 # 3d08 <malloc+0x18a>
    33f4:	00001517          	auipc	a0,0x1
    33f8:	8b450513          	addi	a0,a0,-1868 # 3ca8 <malloc+0x12a>
    33fc:	00000097          	auipc	ra,0x0
    3400:	6c4080e7          	jalr	1732(ra) # 3ac0 <printf>
    3404:	00001517          	auipc	a0,0x1
    3408:	8bc50513          	addi	a0,a0,-1860 # 3cc0 <malloc+0x142>
    340c:	00000097          	auipc	ra,0x0
    3410:	6b4080e7          	jalr	1716(ra) # 3ac0 <printf>
    3414:	4501                	li	a0,0
    3416:	00000097          	auipc	ra,0x0
    341a:	302080e7          	jalr	770(ra) # 3718 <exit>

  printf("TEST PASSED\n");
    341e:	00001517          	auipc	a0,0x1
    3422:	95250513          	addi	a0,a0,-1710 # 3d70 <malloc+0x1f2>
    3426:	00000097          	auipc	ra,0x0
    342a:	69a080e7          	jalr	1690(ra) # 3ac0 <printf>
  exit(0);
    342e:	4501                	li	a0,0
    3430:	00000097          	auipc	ra,0x0
    3434:	2e8080e7          	jalr	744(ra) # 3718 <exit>

0000000000003438 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    3438:	1141                	addi	sp,sp,-16
    343a:	e406                	sd	ra,8(sp)
    343c:	e022                	sd	s0,0(sp)
    343e:	0800                	addi	s0,sp,16
  extern int main();
  main();
    3440:	00000097          	auipc	ra,0x0
    3444:	bc0080e7          	jalr	-1088(ra) # 3000 <main>
  exit(0);
    3448:	4501                	li	a0,0
    344a:	00000097          	auipc	ra,0x0
    344e:	2ce080e7          	jalr	718(ra) # 3718 <exit>

0000000000003452 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    3452:	1141                	addi	sp,sp,-16
    3454:	e422                	sd	s0,8(sp)
    3456:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3458:	87aa                	mv	a5,a0
    345a:	0585                	addi	a1,a1,1
    345c:	0785                	addi	a5,a5,1
    345e:	fff5c703          	lbu	a4,-1(a1)
    3462:	fee78fa3          	sb	a4,-1(a5) # 2fff <main-0x1>
    3466:	fb75                	bnez	a4,345a <strcpy+0x8>
    ;
  return os;
}
    3468:	6422                	ld	s0,8(sp)
    346a:	0141                	addi	sp,sp,16
    346c:	8082                	ret

000000000000346e <strcmp>:

int
strcmp(const char *p, const char *q)
{
    346e:	1141                	addi	sp,sp,-16
    3470:	e422                	sd	s0,8(sp)
    3472:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    3474:	00054783          	lbu	a5,0(a0)
    3478:	cb91                	beqz	a5,348c <strcmp+0x1e>
    347a:	0005c703          	lbu	a4,0(a1)
    347e:	00f71763          	bne	a4,a5,348c <strcmp+0x1e>
    p++, q++;
    3482:	0505                	addi	a0,a0,1
    3484:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    3486:	00054783          	lbu	a5,0(a0)
    348a:	fbe5                	bnez	a5,347a <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    348c:	0005c503          	lbu	a0,0(a1)
}
    3490:	40a7853b          	subw	a0,a5,a0
    3494:	6422                	ld	s0,8(sp)
    3496:	0141                	addi	sp,sp,16
    3498:	8082                	ret

000000000000349a <strlen>:

uint
strlen(const char *s)
{
    349a:	1141                	addi	sp,sp,-16
    349c:	e422                	sd	s0,8(sp)
    349e:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    34a0:	00054783          	lbu	a5,0(a0)
    34a4:	cf91                	beqz	a5,34c0 <strlen+0x26>
    34a6:	0505                	addi	a0,a0,1
    34a8:	87aa                	mv	a5,a0
    34aa:	4685                	li	a3,1
    34ac:	9e89                	subw	a3,a3,a0
    34ae:	00f6853b          	addw	a0,a3,a5
    34b2:	0785                	addi	a5,a5,1
    34b4:	fff7c703          	lbu	a4,-1(a5)
    34b8:	fb7d                	bnez	a4,34ae <strlen+0x14>
    ;
  return n;
}
    34ba:	6422                	ld	s0,8(sp)
    34bc:	0141                	addi	sp,sp,16
    34be:	8082                	ret
  for(n = 0; s[n]; n++)
    34c0:	4501                	li	a0,0
    34c2:	bfe5                	j	34ba <strlen+0x20>

00000000000034c4 <memset>:

void*
memset(void *dst, int c, uint n)
{
    34c4:	1141                	addi	sp,sp,-16
    34c6:	e422                	sd	s0,8(sp)
    34c8:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    34ca:	ca19                	beqz	a2,34e0 <memset+0x1c>
    34cc:	87aa                	mv	a5,a0
    34ce:	1602                	slli	a2,a2,0x20
    34d0:	9201                	srli	a2,a2,0x20
    34d2:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    34d6:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    34da:	0785                	addi	a5,a5,1
    34dc:	fee79de3          	bne	a5,a4,34d6 <memset+0x12>
  }
  return dst;
}
    34e0:	6422                	ld	s0,8(sp)
    34e2:	0141                	addi	sp,sp,16
    34e4:	8082                	ret

00000000000034e6 <strchr>:

char*
strchr(const char *s, char c)
{
    34e6:	1141                	addi	sp,sp,-16
    34e8:	e422                	sd	s0,8(sp)
    34ea:	0800                	addi	s0,sp,16
  for(; *s; s++)
    34ec:	00054783          	lbu	a5,0(a0)
    34f0:	cb99                	beqz	a5,3506 <strchr+0x20>
    if(*s == c)
    34f2:	00f58763          	beq	a1,a5,3500 <strchr+0x1a>
  for(; *s; s++)
    34f6:	0505                	addi	a0,a0,1
    34f8:	00054783          	lbu	a5,0(a0)
    34fc:	fbfd                	bnez	a5,34f2 <strchr+0xc>
      return (char*)s;
  return 0;
    34fe:	4501                	li	a0,0
}
    3500:	6422                	ld	s0,8(sp)
    3502:	0141                	addi	sp,sp,16
    3504:	8082                	ret
  return 0;
    3506:	4501                	li	a0,0
    3508:	bfe5                	j	3500 <strchr+0x1a>

000000000000350a <gets>:

char*
gets(char *buf, int max)
{
    350a:	711d                	addi	sp,sp,-96
    350c:	ec86                	sd	ra,88(sp)
    350e:	e8a2                	sd	s0,80(sp)
    3510:	e4a6                	sd	s1,72(sp)
    3512:	e0ca                	sd	s2,64(sp)
    3514:	fc4e                	sd	s3,56(sp)
    3516:	f852                	sd	s4,48(sp)
    3518:	f456                	sd	s5,40(sp)
    351a:	f05a                	sd	s6,32(sp)
    351c:	ec5e                	sd	s7,24(sp)
    351e:	1080                	addi	s0,sp,96
    3520:	8baa                	mv	s7,a0
    3522:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3524:	892a                	mv	s2,a0
    3526:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    3528:	4aa9                	li	s5,10
    352a:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    352c:	89a6                	mv	s3,s1
    352e:	2485                	addiw	s1,s1,1
    3530:	0344d863          	bge	s1,s4,3560 <gets+0x56>
    cc = read(0, &c, 1);
    3534:	4605                	li	a2,1
    3536:	faf40593          	addi	a1,s0,-81
    353a:	4501                	li	a0,0
    353c:	00000097          	auipc	ra,0x0
    3540:	1fc080e7          	jalr	508(ra) # 3738 <read>
    if(cc < 1)
    3544:	00a05e63          	blez	a0,3560 <gets+0x56>
    buf[i++] = c;
    3548:	faf44783          	lbu	a5,-81(s0)
    354c:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    3550:	01578763          	beq	a5,s5,355e <gets+0x54>
    3554:	0905                	addi	s2,s2,1
    3556:	fd679be3          	bne	a5,s6,352c <gets+0x22>
  for(i=0; i+1 < max; ){
    355a:	89a6                	mv	s3,s1
    355c:	a011                	j	3560 <gets+0x56>
    355e:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    3560:	99de                	add	s3,s3,s7
    3562:	00098023          	sb	zero,0(s3)
  return buf;
}
    3566:	855e                	mv	a0,s7
    3568:	60e6                	ld	ra,88(sp)
    356a:	6446                	ld	s0,80(sp)
    356c:	64a6                	ld	s1,72(sp)
    356e:	6906                	ld	s2,64(sp)
    3570:	79e2                	ld	s3,56(sp)
    3572:	7a42                	ld	s4,48(sp)
    3574:	7aa2                	ld	s5,40(sp)
    3576:	7b02                	ld	s6,32(sp)
    3578:	6be2                	ld	s7,24(sp)
    357a:	6125                	addi	sp,sp,96
    357c:	8082                	ret

000000000000357e <stat>:

int
stat(const char *n, struct stat *st)
{
    357e:	1101                	addi	sp,sp,-32
    3580:	ec06                	sd	ra,24(sp)
    3582:	e822                	sd	s0,16(sp)
    3584:	e426                	sd	s1,8(sp)
    3586:	e04a                	sd	s2,0(sp)
    3588:	1000                	addi	s0,sp,32
    358a:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    358c:	4581                	li	a1,0
    358e:	00000097          	auipc	ra,0x0
    3592:	1d2080e7          	jalr	466(ra) # 3760 <open>
  if(fd < 0)
    3596:	02054563          	bltz	a0,35c0 <stat+0x42>
    359a:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    359c:	85ca                	mv	a1,s2
    359e:	00000097          	auipc	ra,0x0
    35a2:	1da080e7          	jalr	474(ra) # 3778 <fstat>
    35a6:	892a                	mv	s2,a0
  close(fd);
    35a8:	8526                	mv	a0,s1
    35aa:	00000097          	auipc	ra,0x0
    35ae:	19e080e7          	jalr	414(ra) # 3748 <close>
  return r;
}
    35b2:	854a                	mv	a0,s2
    35b4:	60e2                	ld	ra,24(sp)
    35b6:	6442                	ld	s0,16(sp)
    35b8:	64a2                	ld	s1,8(sp)
    35ba:	6902                	ld	s2,0(sp)
    35bc:	6105                	addi	sp,sp,32
    35be:	8082                	ret
    return -1;
    35c0:	597d                	li	s2,-1
    35c2:	bfc5                	j	35b2 <stat+0x34>

00000000000035c4 <atoi>:

int
atoi(const char *s)
{
    35c4:	1141                	addi	sp,sp,-16
    35c6:	e422                	sd	s0,8(sp)
    35c8:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    35ca:	00054603          	lbu	a2,0(a0)
    35ce:	fd06079b          	addiw	a5,a2,-48
    35d2:	0ff7f793          	andi	a5,a5,255
    35d6:	4725                	li	a4,9
    35d8:	02f76963          	bltu	a4,a5,360a <atoi+0x46>
    35dc:	86aa                	mv	a3,a0
  n = 0;
    35de:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    35e0:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    35e2:	0685                	addi	a3,a3,1
    35e4:	0025179b          	slliw	a5,a0,0x2
    35e8:	9fa9                	addw	a5,a5,a0
    35ea:	0017979b          	slliw	a5,a5,0x1
    35ee:	9fb1                	addw	a5,a5,a2
    35f0:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    35f4:	0006c603          	lbu	a2,0(a3)
    35f8:	fd06071b          	addiw	a4,a2,-48
    35fc:	0ff77713          	andi	a4,a4,255
    3600:	fee5f1e3          	bgeu	a1,a4,35e2 <atoi+0x1e>
  return n;
}
    3604:	6422                	ld	s0,8(sp)
    3606:	0141                	addi	sp,sp,16
    3608:	8082                	ret
  n = 0;
    360a:	4501                	li	a0,0
    360c:	bfe5                	j	3604 <atoi+0x40>

000000000000360e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    360e:	1141                	addi	sp,sp,-16
    3610:	e422                	sd	s0,8(sp)
    3612:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    3614:	02b57463          	bgeu	a0,a1,363c <memmove+0x2e>
    while(n-- > 0)
    3618:	00c05f63          	blez	a2,3636 <memmove+0x28>
    361c:	1602                	slli	a2,a2,0x20
    361e:	9201                	srli	a2,a2,0x20
    3620:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    3624:	872a                	mv	a4,a0
      *dst++ = *src++;
    3626:	0585                	addi	a1,a1,1
    3628:	0705                	addi	a4,a4,1
    362a:	fff5c683          	lbu	a3,-1(a1)
    362e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    3632:	fee79ae3          	bne	a5,a4,3626 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    3636:	6422                	ld	s0,8(sp)
    3638:	0141                	addi	sp,sp,16
    363a:	8082                	ret
    dst += n;
    363c:	00c50733          	add	a4,a0,a2
    src += n;
    3640:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    3642:	fec05ae3          	blez	a2,3636 <memmove+0x28>
    3646:	fff6079b          	addiw	a5,a2,-1
    364a:	1782                	slli	a5,a5,0x20
    364c:	9381                	srli	a5,a5,0x20
    364e:	fff7c793          	not	a5,a5
    3652:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    3654:	15fd                	addi	a1,a1,-1
    3656:	177d                	addi	a4,a4,-1
    3658:	0005c683          	lbu	a3,0(a1)
    365c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    3660:	fee79ae3          	bne	a5,a4,3654 <memmove+0x46>
    3664:	bfc9                	j	3636 <memmove+0x28>

0000000000003666 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    3666:	1141                	addi	sp,sp,-16
    3668:	e422                	sd	s0,8(sp)
    366a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    366c:	ca05                	beqz	a2,369c <memcmp+0x36>
    366e:	fff6069b          	addiw	a3,a2,-1
    3672:	1682                	slli	a3,a3,0x20
    3674:	9281                	srli	a3,a3,0x20
    3676:	0685                	addi	a3,a3,1
    3678:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    367a:	00054783          	lbu	a5,0(a0)
    367e:	0005c703          	lbu	a4,0(a1)
    3682:	00e79863          	bne	a5,a4,3692 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    3686:	0505                	addi	a0,a0,1
    p2++;
    3688:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    368a:	fed518e3          	bne	a0,a3,367a <memcmp+0x14>
  }
  return 0;
    368e:	4501                	li	a0,0
    3690:	a019                	j	3696 <memcmp+0x30>
      return *p1 - *p2;
    3692:	40e7853b          	subw	a0,a5,a4
}
    3696:	6422                	ld	s0,8(sp)
    3698:	0141                	addi	sp,sp,16
    369a:	8082                	ret
  return 0;
    369c:	4501                	li	a0,0
    369e:	bfe5                	j	3696 <memcmp+0x30>

00000000000036a0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    36a0:	1141                	addi	sp,sp,-16
    36a2:	e406                	sd	ra,8(sp)
    36a4:	e022                	sd	s0,0(sp)
    36a6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    36a8:	00000097          	auipc	ra,0x0
    36ac:	f66080e7          	jalr	-154(ra) # 360e <memmove>
}
    36b0:	60a2                	ld	ra,8(sp)
    36b2:	6402                	ld	s0,0(sp)
    36b4:	0141                	addi	sp,sp,16
    36b6:	8082                	ret

00000000000036b8 <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    36b8:	1141                	addi	sp,sp,-16
    36ba:	e422                	sd	s0,8(sp)
    36bc:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    36be:	00052023          	sw	zero,0(a0)
}  
    36c2:	6422                	ld	s0,8(sp)
    36c4:	0141                	addi	sp,sp,16
    36c6:	8082                	ret

00000000000036c8 <lock>:

void lock(struct spinlock * lk) 
{    
    36c8:	1141                	addi	sp,sp,-16
    36ca:	e422                	sd	s0,8(sp)
    36cc:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    36ce:	4705                	li	a4,1
    36d0:	87ba                	mv	a5,a4
    36d2:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    36d6:	2781                	sext.w	a5,a5
    36d8:	ffe5                	bnez	a5,36d0 <lock+0x8>
}  
    36da:	6422                	ld	s0,8(sp)
    36dc:	0141                	addi	sp,sp,16
    36de:	8082                	ret

00000000000036e0 <unlock>:

void unlock(struct spinlock * lk) 
{   
    36e0:	1141                	addi	sp,sp,-16
    36e2:	e422                	sd	s0,8(sp)
    36e4:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    36e6:	0f50000f          	fence	iorw,ow
    36ea:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    36ee:	6422                	ld	s0,8(sp)
    36f0:	0141                	addi	sp,sp,16
    36f2:	8082                	ret

00000000000036f4 <isDigit>:

unsigned int isDigit(char *c) {
    36f4:	1141                	addi	sp,sp,-16
    36f6:	e422                	sd	s0,8(sp)
    36f8:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    36fa:	00054503          	lbu	a0,0(a0)
    36fe:	fd05051b          	addiw	a0,a0,-48
    3702:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    3706:	00a53513          	sltiu	a0,a0,10
    370a:	6422                	ld	s0,8(sp)
    370c:	0141                	addi	sp,sp,16
    370e:	8082                	ret

0000000000003710 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    3710:	4885                	li	a7,1
 ecall
    3712:	00000073          	ecall
 ret
    3716:	8082                	ret

0000000000003718 <exit>:
.global exit
exit:
 li a7, SYS_exit
    3718:	4889                	li	a7,2
 ecall
    371a:	00000073          	ecall
 ret
    371e:	8082                	ret

0000000000003720 <wait>:
.global wait
wait:
 li a7, SYS_wait
    3720:	488d                	li	a7,3
 ecall
    3722:	00000073          	ecall
 ret
    3726:	8082                	ret

0000000000003728 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    3728:	48e1                	li	a7,24
 ecall
    372a:	00000073          	ecall
 ret
    372e:	8082                	ret

0000000000003730 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    3730:	4891                	li	a7,4
 ecall
    3732:	00000073          	ecall
 ret
    3736:	8082                	ret

0000000000003738 <read>:
.global read
read:
 li a7, SYS_read
    3738:	4895                	li	a7,5
 ecall
    373a:	00000073          	ecall
 ret
    373e:	8082                	ret

0000000000003740 <write>:
.global write
write:
 li a7, SYS_write
    3740:	48c1                	li	a7,16
 ecall
    3742:	00000073          	ecall
 ret
    3746:	8082                	ret

0000000000003748 <close>:
.global close
close:
 li a7, SYS_close
    3748:	48d5                	li	a7,21
 ecall
    374a:	00000073          	ecall
 ret
    374e:	8082                	ret

0000000000003750 <kill>:
.global kill
kill:
 li a7, SYS_kill
    3750:	4899                	li	a7,6
 ecall
    3752:	00000073          	ecall
 ret
    3756:	8082                	ret

0000000000003758 <exec>:
.global exec
exec:
 li a7, SYS_exec
    3758:	489d                	li	a7,7
 ecall
    375a:	00000073          	ecall
 ret
    375e:	8082                	ret

0000000000003760 <open>:
.global open
open:
 li a7, SYS_open
    3760:	48bd                	li	a7,15
 ecall
    3762:	00000073          	ecall
 ret
    3766:	8082                	ret

0000000000003768 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    3768:	48c5                	li	a7,17
 ecall
    376a:	00000073          	ecall
 ret
    376e:	8082                	ret

0000000000003770 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    3770:	48c9                	li	a7,18
 ecall
    3772:	00000073          	ecall
 ret
    3776:	8082                	ret

0000000000003778 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    3778:	48a1                	li	a7,8
 ecall
    377a:	00000073          	ecall
 ret
    377e:	8082                	ret

0000000000003780 <link>:
.global link
link:
 li a7, SYS_link
    3780:	48cd                	li	a7,19
 ecall
    3782:	00000073          	ecall
 ret
    3786:	8082                	ret

0000000000003788 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    3788:	48d1                	li	a7,20
 ecall
    378a:	00000073          	ecall
 ret
    378e:	8082                	ret

0000000000003790 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    3790:	48a5                	li	a7,9
 ecall
    3792:	00000073          	ecall
 ret
    3796:	8082                	ret

0000000000003798 <dup>:
.global dup
dup:
 li a7, SYS_dup
    3798:	48a9                	li	a7,10
 ecall
    379a:	00000073          	ecall
 ret
    379e:	8082                	ret

00000000000037a0 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    37a0:	48ad                	li	a7,11
 ecall
    37a2:	00000073          	ecall
 ret
    37a6:	8082                	ret

00000000000037a8 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    37a8:	48b1                	li	a7,12
 ecall
    37aa:	00000073          	ecall
 ret
    37ae:	8082                	ret

00000000000037b0 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    37b0:	48b5                	li	a7,13
 ecall
    37b2:	00000073          	ecall
 ret
    37b6:	8082                	ret

00000000000037b8 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    37b8:	48b9                	li	a7,14
 ecall
    37ba:	00000073          	ecall
 ret
    37be:	8082                	ret

00000000000037c0 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    37c0:	48d9                	li	a7,22
 ecall
    37c2:	00000073          	ecall
 ret
    37c6:	8082                	ret

00000000000037c8 <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    37c8:	48dd                	li	a7,23
 ecall
    37ca:	00000073          	ecall
 ret
    37ce:	8082                	ret

00000000000037d0 <ps>:
.global ps
ps:
 li a7, SYS_ps
    37d0:	48e5                	li	a7,25
 ecall
    37d2:	00000073          	ecall
 ret
    37d6:	8082                	ret

00000000000037d8 <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    37d8:	48e9                	li	a7,26
 ecall
    37da:	00000073          	ecall
 ret
    37de:	8082                	ret

00000000000037e0 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    37e0:	48ed                	li	a7,27
 ecall
    37e2:	00000073          	ecall
 ret
    37e6:	8082                	ret

00000000000037e8 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    37e8:	1101                	addi	sp,sp,-32
    37ea:	ec06                	sd	ra,24(sp)
    37ec:	e822                	sd	s0,16(sp)
    37ee:	1000                	addi	s0,sp,32
    37f0:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    37f4:	4605                	li	a2,1
    37f6:	fef40593          	addi	a1,s0,-17
    37fa:	00000097          	auipc	ra,0x0
    37fe:	f46080e7          	jalr	-186(ra) # 3740 <write>
}
    3802:	60e2                	ld	ra,24(sp)
    3804:	6442                	ld	s0,16(sp)
    3806:	6105                	addi	sp,sp,32
    3808:	8082                	ret

000000000000380a <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    380a:	7139                	addi	sp,sp,-64
    380c:	fc06                	sd	ra,56(sp)
    380e:	f822                	sd	s0,48(sp)
    3810:	f426                	sd	s1,40(sp)
    3812:	f04a                	sd	s2,32(sp)
    3814:	ec4e                	sd	s3,24(sp)
    3816:	0080                	addi	s0,sp,64
    3818:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    381a:	c299                	beqz	a3,3820 <printint+0x16>
    381c:	0805c863          	bltz	a1,38ac <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3820:	2581                	sext.w	a1,a1
  neg = 0;
    3822:	4881                	li	a7,0
    3824:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    3828:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    382a:	2601                	sext.w	a2,a2
    382c:	00000517          	auipc	a0,0x0
    3830:	55c50513          	addi	a0,a0,1372 # 3d88 <digits>
    3834:	883a                	mv	a6,a4
    3836:	2705                	addiw	a4,a4,1
    3838:	02c5f7bb          	remuw	a5,a1,a2
    383c:	1782                	slli	a5,a5,0x20
    383e:	9381                	srli	a5,a5,0x20
    3840:	97aa                	add	a5,a5,a0
    3842:	0007c783          	lbu	a5,0(a5)
    3846:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    384a:	0005879b          	sext.w	a5,a1
    384e:	02c5d5bb          	divuw	a1,a1,a2
    3852:	0685                	addi	a3,a3,1
    3854:	fec7f0e3          	bgeu	a5,a2,3834 <printint+0x2a>
  if(neg)
    3858:	00088b63          	beqz	a7,386e <printint+0x64>
    buf[i++] = '-';
    385c:	fd040793          	addi	a5,s0,-48
    3860:	973e                	add	a4,a4,a5
    3862:	02d00793          	li	a5,45
    3866:	fef70823          	sb	a5,-16(a4)
    386a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    386e:	02e05863          	blez	a4,389e <printint+0x94>
    3872:	fc040793          	addi	a5,s0,-64
    3876:	00e78933          	add	s2,a5,a4
    387a:	fff78993          	addi	s3,a5,-1
    387e:	99ba                	add	s3,s3,a4
    3880:	377d                	addiw	a4,a4,-1
    3882:	1702                	slli	a4,a4,0x20
    3884:	9301                	srli	a4,a4,0x20
    3886:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    388a:	fff94583          	lbu	a1,-1(s2)
    388e:	8526                	mv	a0,s1
    3890:	00000097          	auipc	ra,0x0
    3894:	f58080e7          	jalr	-168(ra) # 37e8 <putc>
  while(--i >= 0)
    3898:	197d                	addi	s2,s2,-1
    389a:	ff3918e3          	bne	s2,s3,388a <printint+0x80>
}
    389e:	70e2                	ld	ra,56(sp)
    38a0:	7442                	ld	s0,48(sp)
    38a2:	74a2                	ld	s1,40(sp)
    38a4:	7902                	ld	s2,32(sp)
    38a6:	69e2                	ld	s3,24(sp)
    38a8:	6121                	addi	sp,sp,64
    38aa:	8082                	ret
    x = -xx;
    38ac:	40b005bb          	negw	a1,a1
    neg = 1;
    38b0:	4885                	li	a7,1
    x = -xx;
    38b2:	bf8d                	j	3824 <printint+0x1a>

00000000000038b4 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    38b4:	7119                	addi	sp,sp,-128
    38b6:	fc86                	sd	ra,120(sp)
    38b8:	f8a2                	sd	s0,112(sp)
    38ba:	f4a6                	sd	s1,104(sp)
    38bc:	f0ca                	sd	s2,96(sp)
    38be:	ecce                	sd	s3,88(sp)
    38c0:	e8d2                	sd	s4,80(sp)
    38c2:	e4d6                	sd	s5,72(sp)
    38c4:	e0da                	sd	s6,64(sp)
    38c6:	fc5e                	sd	s7,56(sp)
    38c8:	f862                	sd	s8,48(sp)
    38ca:	f466                	sd	s9,40(sp)
    38cc:	f06a                	sd	s10,32(sp)
    38ce:	ec6e                	sd	s11,24(sp)
    38d0:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    38d2:	0005c903          	lbu	s2,0(a1)
    38d6:	18090f63          	beqz	s2,3a74 <vprintf+0x1c0>
    38da:	8aaa                	mv	s5,a0
    38dc:	8b32                	mv	s6,a2
    38de:	00158493          	addi	s1,a1,1
  state = 0;
    38e2:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    38e4:	02500a13          	li	s4,37
      if(c == 'd'){
    38e8:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    38ec:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    38f0:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    38f4:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    38f8:	00000b97          	auipc	s7,0x0
    38fc:	490b8b93          	addi	s7,s7,1168 # 3d88 <digits>
    3900:	a839                	j	391e <vprintf+0x6a>
        putc(fd, c);
    3902:	85ca                	mv	a1,s2
    3904:	8556                	mv	a0,s5
    3906:	00000097          	auipc	ra,0x0
    390a:	ee2080e7          	jalr	-286(ra) # 37e8 <putc>
    390e:	a019                	j	3914 <vprintf+0x60>
    } else if(state == '%'){
    3910:	01498f63          	beq	s3,s4,392e <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    3914:	0485                	addi	s1,s1,1
    3916:	fff4c903          	lbu	s2,-1(s1)
    391a:	14090d63          	beqz	s2,3a74 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    391e:	0009079b          	sext.w	a5,s2
    if(state == 0){
    3922:	fe0997e3          	bnez	s3,3910 <vprintf+0x5c>
      if(c == '%'){
    3926:	fd479ee3          	bne	a5,s4,3902 <vprintf+0x4e>
        state = '%';
    392a:	89be                	mv	s3,a5
    392c:	b7e5                	j	3914 <vprintf+0x60>
      if(c == 'd'){
    392e:	05878063          	beq	a5,s8,396e <vprintf+0xba>
      } else if(c == 'l') {
    3932:	05978c63          	beq	a5,s9,398a <vprintf+0xd6>
      } else if(c == 'x') {
    3936:	07a78863          	beq	a5,s10,39a6 <vprintf+0xf2>
      } else if(c == 'p') {
    393a:	09b78463          	beq	a5,s11,39c2 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    393e:	07300713          	li	a4,115
    3942:	0ce78663          	beq	a5,a4,3a0e <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3946:	06300713          	li	a4,99
    394a:	0ee78e63          	beq	a5,a4,3a46 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    394e:	11478863          	beq	a5,s4,3a5e <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3952:	85d2                	mv	a1,s4
    3954:	8556                	mv	a0,s5
    3956:	00000097          	auipc	ra,0x0
    395a:	e92080e7          	jalr	-366(ra) # 37e8 <putc>
        putc(fd, c);
    395e:	85ca                	mv	a1,s2
    3960:	8556                	mv	a0,s5
    3962:	00000097          	auipc	ra,0x0
    3966:	e86080e7          	jalr	-378(ra) # 37e8 <putc>
      }
      state = 0;
    396a:	4981                	li	s3,0
    396c:	b765                	j	3914 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    396e:	008b0913          	addi	s2,s6,8
    3972:	4685                	li	a3,1
    3974:	4629                	li	a2,10
    3976:	000b2583          	lw	a1,0(s6)
    397a:	8556                	mv	a0,s5
    397c:	00000097          	auipc	ra,0x0
    3980:	e8e080e7          	jalr	-370(ra) # 380a <printint>
    3984:	8b4a                	mv	s6,s2
      state = 0;
    3986:	4981                	li	s3,0
    3988:	b771                	j	3914 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    398a:	008b0913          	addi	s2,s6,8
    398e:	4681                	li	a3,0
    3990:	4629                	li	a2,10
    3992:	000b2583          	lw	a1,0(s6)
    3996:	8556                	mv	a0,s5
    3998:	00000097          	auipc	ra,0x0
    399c:	e72080e7          	jalr	-398(ra) # 380a <printint>
    39a0:	8b4a                	mv	s6,s2
      state = 0;
    39a2:	4981                	li	s3,0
    39a4:	bf85                	j	3914 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    39a6:	008b0913          	addi	s2,s6,8
    39aa:	4681                	li	a3,0
    39ac:	4641                	li	a2,16
    39ae:	000b2583          	lw	a1,0(s6)
    39b2:	8556                	mv	a0,s5
    39b4:	00000097          	auipc	ra,0x0
    39b8:	e56080e7          	jalr	-426(ra) # 380a <printint>
    39bc:	8b4a                	mv	s6,s2
      state = 0;
    39be:	4981                	li	s3,0
    39c0:	bf91                	j	3914 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    39c2:	008b0793          	addi	a5,s6,8
    39c6:	f8f43423          	sd	a5,-120(s0)
    39ca:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    39ce:	03000593          	li	a1,48
    39d2:	8556                	mv	a0,s5
    39d4:	00000097          	auipc	ra,0x0
    39d8:	e14080e7          	jalr	-492(ra) # 37e8 <putc>
  putc(fd, 'x');
    39dc:	85ea                	mv	a1,s10
    39de:	8556                	mv	a0,s5
    39e0:	00000097          	auipc	ra,0x0
    39e4:	e08080e7          	jalr	-504(ra) # 37e8 <putc>
    39e8:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    39ea:	03c9d793          	srli	a5,s3,0x3c
    39ee:	97de                	add	a5,a5,s7
    39f0:	0007c583          	lbu	a1,0(a5)
    39f4:	8556                	mv	a0,s5
    39f6:	00000097          	auipc	ra,0x0
    39fa:	df2080e7          	jalr	-526(ra) # 37e8 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    39fe:	0992                	slli	s3,s3,0x4
    3a00:	397d                	addiw	s2,s2,-1
    3a02:	fe0914e3          	bnez	s2,39ea <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    3a06:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    3a0a:	4981                	li	s3,0
    3a0c:	b721                	j	3914 <vprintf+0x60>
        s = va_arg(ap, char*);
    3a0e:	008b0993          	addi	s3,s6,8
    3a12:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    3a16:	02090163          	beqz	s2,3a38 <vprintf+0x184>
        while(*s != 0){
    3a1a:	00094583          	lbu	a1,0(s2)
    3a1e:	c9a1                	beqz	a1,3a6e <vprintf+0x1ba>
          putc(fd, *s);
    3a20:	8556                	mv	a0,s5
    3a22:	00000097          	auipc	ra,0x0
    3a26:	dc6080e7          	jalr	-570(ra) # 37e8 <putc>
          s++;
    3a2a:	0905                	addi	s2,s2,1
        while(*s != 0){
    3a2c:	00094583          	lbu	a1,0(s2)
    3a30:	f9e5                	bnez	a1,3a20 <vprintf+0x16c>
        s = va_arg(ap, char*);
    3a32:	8b4e                	mv	s6,s3
      state = 0;
    3a34:	4981                	li	s3,0
    3a36:	bdf9                	j	3914 <vprintf+0x60>
          s = "(null)";
    3a38:	00000917          	auipc	s2,0x0
    3a3c:	34890913          	addi	s2,s2,840 # 3d80 <malloc+0x202>
        while(*s != 0){
    3a40:	02800593          	li	a1,40
    3a44:	bff1                	j	3a20 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    3a46:	008b0913          	addi	s2,s6,8
    3a4a:	000b4583          	lbu	a1,0(s6)
    3a4e:	8556                	mv	a0,s5
    3a50:	00000097          	auipc	ra,0x0
    3a54:	d98080e7          	jalr	-616(ra) # 37e8 <putc>
    3a58:	8b4a                	mv	s6,s2
      state = 0;
    3a5a:	4981                	li	s3,0
    3a5c:	bd65                	j	3914 <vprintf+0x60>
        putc(fd, c);
    3a5e:	85d2                	mv	a1,s4
    3a60:	8556                	mv	a0,s5
    3a62:	00000097          	auipc	ra,0x0
    3a66:	d86080e7          	jalr	-634(ra) # 37e8 <putc>
      state = 0;
    3a6a:	4981                	li	s3,0
    3a6c:	b565                	j	3914 <vprintf+0x60>
        s = va_arg(ap, char*);
    3a6e:	8b4e                	mv	s6,s3
      state = 0;
    3a70:	4981                	li	s3,0
    3a72:	b54d                	j	3914 <vprintf+0x60>
    }
  }
}
    3a74:	70e6                	ld	ra,120(sp)
    3a76:	7446                	ld	s0,112(sp)
    3a78:	74a6                	ld	s1,104(sp)
    3a7a:	7906                	ld	s2,96(sp)
    3a7c:	69e6                	ld	s3,88(sp)
    3a7e:	6a46                	ld	s4,80(sp)
    3a80:	6aa6                	ld	s5,72(sp)
    3a82:	6b06                	ld	s6,64(sp)
    3a84:	7be2                	ld	s7,56(sp)
    3a86:	7c42                	ld	s8,48(sp)
    3a88:	7ca2                	ld	s9,40(sp)
    3a8a:	7d02                	ld	s10,32(sp)
    3a8c:	6de2                	ld	s11,24(sp)
    3a8e:	6109                	addi	sp,sp,128
    3a90:	8082                	ret

0000000000003a92 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    3a92:	715d                	addi	sp,sp,-80
    3a94:	ec06                	sd	ra,24(sp)
    3a96:	e822                	sd	s0,16(sp)
    3a98:	1000                	addi	s0,sp,32
    3a9a:	e010                	sd	a2,0(s0)
    3a9c:	e414                	sd	a3,8(s0)
    3a9e:	e818                	sd	a4,16(s0)
    3aa0:	ec1c                	sd	a5,24(s0)
    3aa2:	03043023          	sd	a6,32(s0)
    3aa6:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    3aaa:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    3aae:	8622                	mv	a2,s0
    3ab0:	00000097          	auipc	ra,0x0
    3ab4:	e04080e7          	jalr	-508(ra) # 38b4 <vprintf>
}
    3ab8:	60e2                	ld	ra,24(sp)
    3aba:	6442                	ld	s0,16(sp)
    3abc:	6161                	addi	sp,sp,80
    3abe:	8082                	ret

0000000000003ac0 <printf>:

void
printf(const char *fmt, ...)
{
    3ac0:	711d                	addi	sp,sp,-96
    3ac2:	ec06                	sd	ra,24(sp)
    3ac4:	e822                	sd	s0,16(sp)
    3ac6:	1000                	addi	s0,sp,32
    3ac8:	e40c                	sd	a1,8(s0)
    3aca:	e810                	sd	a2,16(s0)
    3acc:	ec14                	sd	a3,24(s0)
    3ace:	f018                	sd	a4,32(s0)
    3ad0:	f41c                	sd	a5,40(s0)
    3ad2:	03043823          	sd	a6,48(s0)
    3ad6:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    3ada:	00840613          	addi	a2,s0,8
    3ade:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    3ae2:	85aa                	mv	a1,a0
    3ae4:	4505                	li	a0,1
    3ae6:	00000097          	auipc	ra,0x0
    3aea:	dce080e7          	jalr	-562(ra) # 38b4 <vprintf>
}
    3aee:	60e2                	ld	ra,24(sp)
    3af0:	6442                	ld	s0,16(sp)
    3af2:	6125                	addi	sp,sp,96
    3af4:	8082                	ret

0000000000003af6 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3af6:	1141                	addi	sp,sp,-16
    3af8:	e422                	sd	s0,8(sp)
    3afa:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3afc:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3b00:	00000797          	auipc	a5,0x0
    3b04:	5007b783          	ld	a5,1280(a5) # 4000 <freep>
    3b08:	a805                	j	3b38 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3b0a:	4618                	lw	a4,8(a2)
    3b0c:	9db9                	addw	a1,a1,a4
    3b0e:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    3b12:	6398                	ld	a4,0(a5)
    3b14:	6318                	ld	a4,0(a4)
    3b16:	fee53823          	sd	a4,-16(a0)
    3b1a:	a091                	j	3b5e <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    3b1c:	ff852703          	lw	a4,-8(a0)
    3b20:	9e39                	addw	a2,a2,a4
    3b22:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    3b24:	ff053703          	ld	a4,-16(a0)
    3b28:	e398                	sd	a4,0(a5)
    3b2a:	a099                	j	3b70 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3b2c:	6398                	ld	a4,0(a5)
    3b2e:	00e7e463          	bltu	a5,a4,3b36 <free+0x40>
    3b32:	00e6ea63          	bltu	a3,a4,3b46 <free+0x50>
{
    3b36:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3b38:	fed7fae3          	bgeu	a5,a3,3b2c <free+0x36>
    3b3c:	6398                	ld	a4,0(a5)
    3b3e:	00e6e463          	bltu	a3,a4,3b46 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3b42:	fee7eae3          	bltu	a5,a4,3b36 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    3b46:	ff852583          	lw	a1,-8(a0)
    3b4a:	6390                	ld	a2,0(a5)
    3b4c:	02059713          	slli	a4,a1,0x20
    3b50:	9301                	srli	a4,a4,0x20
    3b52:	0712                	slli	a4,a4,0x4
    3b54:	9736                	add	a4,a4,a3
    3b56:	fae60ae3          	beq	a2,a4,3b0a <free+0x14>
    bp->s.ptr = p->s.ptr;
    3b5a:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    3b5e:	4790                	lw	a2,8(a5)
    3b60:	02061713          	slli	a4,a2,0x20
    3b64:	9301                	srli	a4,a4,0x20
    3b66:	0712                	slli	a4,a4,0x4
    3b68:	973e                	add	a4,a4,a5
    3b6a:	fae689e3          	beq	a3,a4,3b1c <free+0x26>
  } else
    p->s.ptr = bp;
    3b6e:	e394                	sd	a3,0(a5)
  freep = p;
    3b70:	00000717          	auipc	a4,0x0
    3b74:	48f73823          	sd	a5,1168(a4) # 4000 <freep>
}
    3b78:	6422                	ld	s0,8(sp)
    3b7a:	0141                	addi	sp,sp,16
    3b7c:	8082                	ret

0000000000003b7e <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3b7e:	7139                	addi	sp,sp,-64
    3b80:	fc06                	sd	ra,56(sp)
    3b82:	f822                	sd	s0,48(sp)
    3b84:	f426                	sd	s1,40(sp)
    3b86:	f04a                	sd	s2,32(sp)
    3b88:	ec4e                	sd	s3,24(sp)
    3b8a:	e852                	sd	s4,16(sp)
    3b8c:	e456                	sd	s5,8(sp)
    3b8e:	e05a                	sd	s6,0(sp)
    3b90:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3b92:	02051493          	slli	s1,a0,0x20
    3b96:	9081                	srli	s1,s1,0x20
    3b98:	04bd                	addi	s1,s1,15
    3b9a:	8091                	srli	s1,s1,0x4
    3b9c:	0014899b          	addiw	s3,s1,1
    3ba0:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    3ba2:	00000517          	auipc	a0,0x0
    3ba6:	45e53503          	ld	a0,1118(a0) # 4000 <freep>
    3baa:	c515                	beqz	a0,3bd6 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3bac:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3bae:	4798                	lw	a4,8(a5)
    3bb0:	02977f63          	bgeu	a4,s1,3bee <malloc+0x70>
    3bb4:	8a4e                	mv	s4,s3
    3bb6:	0009871b          	sext.w	a4,s3
    3bba:	6685                	lui	a3,0x1
    3bbc:	00d77363          	bgeu	a4,a3,3bc2 <malloc+0x44>
    3bc0:	6a05                	lui	s4,0x1
    3bc2:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    3bc6:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3bca:	00000917          	auipc	s2,0x0
    3bce:	43690913          	addi	s2,s2,1078 # 4000 <freep>
  if(p == (char*)-1)
    3bd2:	5afd                	li	s5,-1
    3bd4:	a88d                	j	3c46 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    3bd6:	00000797          	auipc	a5,0x0
    3bda:	43a78793          	addi	a5,a5,1082 # 4010 <base>
    3bde:	00000717          	auipc	a4,0x0
    3be2:	42f73123          	sd	a5,1058(a4) # 4000 <freep>
    3be6:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    3be8:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    3bec:	b7e1                	j	3bb4 <malloc+0x36>
      if(p->s.size == nunits)
    3bee:	02e48b63          	beq	s1,a4,3c24 <malloc+0xa6>
        p->s.size -= nunits;
    3bf2:	4137073b          	subw	a4,a4,s3
    3bf6:	c798                	sw	a4,8(a5)
        p += p->s.size;
    3bf8:	1702                	slli	a4,a4,0x20
    3bfa:	9301                	srli	a4,a4,0x20
    3bfc:	0712                	slli	a4,a4,0x4
    3bfe:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    3c00:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    3c04:	00000717          	auipc	a4,0x0
    3c08:	3ea73e23          	sd	a0,1020(a4) # 4000 <freep>
      return (void*)(p + 1);
    3c0c:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3c10:	70e2                	ld	ra,56(sp)
    3c12:	7442                	ld	s0,48(sp)
    3c14:	74a2                	ld	s1,40(sp)
    3c16:	7902                	ld	s2,32(sp)
    3c18:	69e2                	ld	s3,24(sp)
    3c1a:	6a42                	ld	s4,16(sp)
    3c1c:	6aa2                	ld	s5,8(sp)
    3c1e:	6b02                	ld	s6,0(sp)
    3c20:	6121                	addi	sp,sp,64
    3c22:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    3c24:	6398                	ld	a4,0(a5)
    3c26:	e118                	sd	a4,0(a0)
    3c28:	bff1                	j	3c04 <malloc+0x86>
  hp->s.size = nu;
    3c2a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    3c2e:	0541                	addi	a0,a0,16
    3c30:	00000097          	auipc	ra,0x0
    3c34:	ec6080e7          	jalr	-314(ra) # 3af6 <free>
  return freep;
    3c38:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    3c3c:	d971                	beqz	a0,3c10 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3c3e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3c40:	4798                	lw	a4,8(a5)
    3c42:	fa9776e3          	bgeu	a4,s1,3bee <malloc+0x70>
    if(p == freep)
    3c46:	00093703          	ld	a4,0(s2)
    3c4a:	853e                	mv	a0,a5
    3c4c:	fef719e3          	bne	a4,a5,3c3e <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3c50:	8552                	mv	a0,s4
    3c52:	00000097          	auipc	ra,0x0
    3c56:	b56080e7          	jalr	-1194(ra) # 37a8 <sbrk>
  if(p == (char*)-1)
    3c5a:	fd5518e3          	bne	a0,s5,3c2a <malloc+0xac>
        return 0;
    3c5e:	4501                	li	a0,0
    3c60:	bf45                	j	3c10 <malloc+0x92>
