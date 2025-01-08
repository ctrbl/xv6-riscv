
user/_grind:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <do_rand>:
#include "kernel/riscv.h"

// from FreeBSD.
int
do_rand(unsigned long *ctx)
{
    3000:	1141                	addi	sp,sp,-16
    3002:	e422                	sd	s0,8(sp)
    3004:	0800                	addi	s0,sp,16
 * October 1988, p. 1195.
 */
    long hi, lo, x;

    /* Transform to [1, 0x7ffffffe] range. */
    x = (*ctx % 0x7ffffffe) + 1;
    3006:	611c                	ld	a5,0(a0)
    3008:	80000737          	lui	a4,0x80000
    300c:	ffe74713          	xori	a4,a4,-2
    3010:	02e7f7b3          	remu	a5,a5,a4
    3014:	0785                	addi	a5,a5,1
    hi = x / 127773;
    lo = x % 127773;
    3016:	66fd                	lui	a3,0x1f
    3018:	31d68693          	addi	a3,a3,797 # 1f31d <base+0x19f15>
    301c:	02d7e733          	rem	a4,a5,a3
    x = 16807 * lo - 2836 * hi;
    3020:	6611                	lui	a2,0x4
    3022:	1a760613          	addi	a2,a2,423 # 41a7 <vprintf+0x11f>
    3026:	02c70733          	mul	a4,a4,a2
    hi = x / 127773;
    302a:	02d7c7b3          	div	a5,a5,a3
    x = 16807 * lo - 2836 * hi;
    302e:	76fd                	lui	a3,0xfffff
    3030:	4ec68693          	addi	a3,a3,1260 # fffffffffffff4ec <base+0xffffffffffffa0e4>
    3034:	02d787b3          	mul	a5,a5,a3
    3038:	97ba                	add	a5,a5,a4
    if (x < 0)
    303a:	0007c963          	bltz	a5,304c <do_rand+0x4c>
        x += 0x7fffffff;
    /* Transform to [0, 0x7ffffffd] range. */
    x--;
    303e:	17fd                	addi	a5,a5,-1
    *ctx = x;
    3040:	e11c                	sd	a5,0(a0)
    return (x);
}
    3042:	0007851b          	sext.w	a0,a5
    3046:	6422                	ld	s0,8(sp)
    3048:	0141                	addi	sp,sp,16
    304a:	8082                	ret
        x += 0x7fffffff;
    304c:	80000737          	lui	a4,0x80000
    3050:	fff74713          	not	a4,a4
    3054:	97ba                	add	a5,a5,a4
    3056:	b7e5                	j	303e <do_rand+0x3e>

0000000000003058 <rand>:

unsigned long rand_next = 1;

int
rand(void)
{
    3058:	1141                	addi	sp,sp,-16
    305a:	e406                	sd	ra,8(sp)
    305c:	e022                	sd	s0,0(sp)
    305e:	0800                	addi	s0,sp,16
    return (do_rand(&rand_next));
    3060:	00002517          	auipc	a0,0x2
    3064:	fa050513          	addi	a0,a0,-96 # 5000 <rand_next>
    3068:	00000097          	auipc	ra,0x0
    306c:	f98080e7          	jalr	-104(ra) # 3000 <do_rand>
}
    3070:	60a2                	ld	ra,8(sp)
    3072:	6402                	ld	s0,0(sp)
    3074:	0141                	addi	sp,sp,16
    3076:	8082                	ret

0000000000003078 <go>:

void
go(int which_child)
{
    3078:	7159                	addi	sp,sp,-112
    307a:	f486                	sd	ra,104(sp)
    307c:	f0a2                	sd	s0,96(sp)
    307e:	eca6                	sd	s1,88(sp)
    3080:	e8ca                	sd	s2,80(sp)
    3082:	e4ce                	sd	s3,72(sp)
    3084:	e0d2                	sd	s4,64(sp)
    3086:	fc56                	sd	s5,56(sp)
    3088:	f85a                	sd	s6,48(sp)
    308a:	1880                	addi	s0,sp,112
    308c:	84aa                	mv	s1,a0
  int fd = -1;
  static char buf[999];
  char *break0 = sbrk(0);
    308e:	4501                	li	a0,0
    3090:	00001097          	auipc	ra,0x1
    3094:	eec080e7          	jalr	-276(ra) # 3f7c <sbrk>
    3098:	8aaa                	mv	s5,a0
  uint64 iters = 0;

  mkdir("grindir");
    309a:	00001517          	auipc	a0,0x1
    309e:	3a650513          	addi	a0,a0,934 # 4440 <malloc+0xee>
    30a2:	00001097          	auipc	ra,0x1
    30a6:	eba080e7          	jalr	-326(ra) # 3f5c <mkdir>
  if(chdir("grindir") != 0){
    30aa:	00001517          	auipc	a0,0x1
    30ae:	39650513          	addi	a0,a0,918 # 4440 <malloc+0xee>
    30b2:	00001097          	auipc	ra,0x1
    30b6:	eb2080e7          	jalr	-334(ra) # 3f64 <chdir>
    30ba:	cd11                	beqz	a0,30d6 <go+0x5e>
    printf("grind: chdir grindir failed\n");
    30bc:	00001517          	auipc	a0,0x1
    30c0:	38c50513          	addi	a0,a0,908 # 4448 <malloc+0xf6>
    30c4:	00001097          	auipc	ra,0x1
    30c8:	1d0080e7          	jalr	464(ra) # 4294 <printf>
    exit(1);
    30cc:	4505                	li	a0,1
    30ce:	00001097          	auipc	ra,0x1
    30d2:	e1e080e7          	jalr	-482(ra) # 3eec <exit>
  }
  chdir("/");
    30d6:	00001517          	auipc	a0,0x1
    30da:	39250513          	addi	a0,a0,914 # 4468 <malloc+0x116>
    30de:	00001097          	auipc	ra,0x1
    30e2:	e86080e7          	jalr	-378(ra) # 3f64 <chdir>
  
  while(1){
    iters++;
    if((iters % 500) == 0)
    30e6:	00001997          	auipc	s3,0x1
    30ea:	39298993          	addi	s3,s3,914 # 4478 <malloc+0x126>
    30ee:	c489                	beqz	s1,30f8 <go+0x80>
    30f0:	00001997          	auipc	s3,0x1
    30f4:	38098993          	addi	s3,s3,896 # 4470 <malloc+0x11e>
    iters++;
    30f8:	4485                	li	s1,1
  int fd = -1;
    30fa:	597d                	li	s2,-1
      close(fd);
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
    } else if(what == 7){
      write(fd, buf, sizeof(buf));
    } else if(what == 8){
      read(fd, buf, sizeof(buf));
    30fc:	00002a17          	auipc	s4,0x2
    3100:	f24a0a13          	addi	s4,s4,-220 # 5020 <buf.0>
    3104:	a825                	j	313c <go+0xc4>
      close(open("grindir/../a", O_CREATE|O_RDWR));
    3106:	20200593          	li	a1,514
    310a:	00001517          	auipc	a0,0x1
    310e:	37650513          	addi	a0,a0,886 # 4480 <malloc+0x12e>
    3112:	00001097          	auipc	ra,0x1
    3116:	e22080e7          	jalr	-478(ra) # 3f34 <open>
    311a:	00001097          	auipc	ra,0x1
    311e:	e02080e7          	jalr	-510(ra) # 3f1c <close>
    iters++;
    3122:	0485                	addi	s1,s1,1
    if((iters % 500) == 0)
    3124:	1f400793          	li	a5,500
    3128:	02f4f7b3          	remu	a5,s1,a5
    312c:	eb81                	bnez	a5,313c <go+0xc4>
      write(1, which_child?"B":"A", 1);
    312e:	4605                	li	a2,1
    3130:	85ce                	mv	a1,s3
    3132:	4505                	li	a0,1
    3134:	00001097          	auipc	ra,0x1
    3138:	de0080e7          	jalr	-544(ra) # 3f14 <write>
    int what = rand() % 23;
    313c:	00000097          	auipc	ra,0x0
    3140:	f1c080e7          	jalr	-228(ra) # 3058 <rand>
    3144:	47dd                	li	a5,23
    3146:	02f5653b          	remw	a0,a0,a5
    if(what == 1){
    314a:	4785                	li	a5,1
    314c:	faf50de3          	beq	a0,a5,3106 <go+0x8e>
    } else if(what == 2){
    3150:	4789                	li	a5,2
    3152:	18f50563          	beq	a0,a5,32dc <go+0x264>
    } else if(what == 3){
    3156:	478d                	li	a5,3
    3158:	1af50163          	beq	a0,a5,32fa <go+0x282>
    } else if(what == 4){
    315c:	4791                	li	a5,4
    315e:	1af50763          	beq	a0,a5,330c <go+0x294>
    } else if(what == 5){
    3162:	4795                	li	a5,5
    3164:	1ef50b63          	beq	a0,a5,335a <go+0x2e2>
    } else if(what == 6){
    3168:	4799                	li	a5,6
    316a:	20f50963          	beq	a0,a5,337c <go+0x304>
    } else if(what == 7){
    316e:	479d                	li	a5,7
    3170:	22f50763          	beq	a0,a5,339e <go+0x326>
    } else if(what == 8){
    3174:	47a1                	li	a5,8
    3176:	22f50d63          	beq	a0,a5,33b0 <go+0x338>
    } else if(what == 9){
    317a:	47a5                	li	a5,9
    317c:	24f50363          	beq	a0,a5,33c2 <go+0x34a>
      mkdir("grindir/../a");
      close(open("a/../a/./a", O_CREATE|O_RDWR));
      unlink("a/a");
    } else if(what == 10){
    3180:	47a9                	li	a5,10
    3182:	26f50f63          	beq	a0,a5,3400 <go+0x388>
      mkdir("/../b");
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
      unlink("b/b");
    } else if(what == 11){
    3186:	47ad                	li	a5,11
    3188:	2af50b63          	beq	a0,a5,343e <go+0x3c6>
      unlink("b");
      link("../grindir/./../a", "../b");
    } else if(what == 12){
    318c:	47b1                	li	a5,12
    318e:	2cf50d63          	beq	a0,a5,3468 <go+0x3f0>
      unlink("../grindir/../a");
      link(".././b", "/grindir/../a");
    } else if(what == 13){
    3192:	47b5                	li	a5,13
    3194:	2ef50f63          	beq	a0,a5,3492 <go+0x41a>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 14){
    3198:	47b9                	li	a5,14
    319a:	32f50a63          	beq	a0,a5,34ce <go+0x456>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 15){
    319e:	47bd                	li	a5,15
    31a0:	36f50e63          	beq	a0,a5,351c <go+0x4a4>
      sbrk(6011);
    } else if(what == 16){
    31a4:	47c1                	li	a5,16
    31a6:	38f50363          	beq	a0,a5,352c <go+0x4b4>
      if(sbrk(0) > break0)
        sbrk(-(sbrk(0) - break0));
    } else if(what == 17){
    31aa:	47c5                	li	a5,17
    31ac:	3af50363          	beq	a0,a5,3552 <go+0x4da>
        printf("grind: chdir failed\n");
        exit(1);
      }
      kill(pid);
      wait(0);
    } else if(what == 18){
    31b0:	47c9                	li	a5,18
    31b2:	42f50963          	beq	a0,a5,35e4 <go+0x56c>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 19){
    31b6:	47cd                	li	a5,19
    31b8:	46f50d63          	beq	a0,a5,3632 <go+0x5ba>
        exit(1);
      }
      close(fds[0]);
      close(fds[1]);
      wait(0);
    } else if(what == 20){
    31bc:	47d1                	li	a5,20
    31be:	54f50e63          	beq	a0,a5,371a <go+0x6a2>
      } else if(pid < 0){
        printf("grind: fork failed\n");
        exit(1);
      }
      wait(0);
    } else if(what == 21){
    31c2:	47d5                	li	a5,21
    31c4:	5ef50c63          	beq	a0,a5,37bc <go+0x744>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
        exit(1);
      }
      close(fd1);
      unlink("c");
    } else if(what == 22){
    31c8:	47d9                	li	a5,22
    31ca:	f4f51ce3          	bne	a0,a5,3122 <go+0xaa>
      // echo hi | cat
      int aa[2], bb[2];
      if(pipe(aa) < 0){
    31ce:	f9840513          	addi	a0,s0,-104
    31d2:	00001097          	auipc	ra,0x1
    31d6:	d32080e7          	jalr	-718(ra) # 3f04 <pipe>
    31da:	6e054563          	bltz	a0,38c4 <go+0x84c>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      if(pipe(bb) < 0){
    31de:	fa040513          	addi	a0,s0,-96
    31e2:	00001097          	auipc	ra,0x1
    31e6:	d22080e7          	jalr	-734(ra) # 3f04 <pipe>
    31ea:	6e054b63          	bltz	a0,38e0 <go+0x868>
        fprintf(2, "grind: pipe failed\n");
        exit(1);
      }
      int pid1 = fork();
    31ee:	00001097          	auipc	ra,0x1
    31f2:	cf6080e7          	jalr	-778(ra) # 3ee4 <fork>
      if(pid1 == 0){
    31f6:	70050363          	beqz	a0,38fc <go+0x884>
        close(aa[1]);
        char *args[3] = { "echo", "hi", 0 };
        exec("grindir/../echo", args);
        fprintf(2, "grind: echo: not found\n");
        exit(2);
      } else if(pid1 < 0){
    31fa:	7a054b63          	bltz	a0,39b0 <go+0x938>
        fprintf(2, "grind: fork failed\n");
        exit(3);
      }
      int pid2 = fork();
    31fe:	00001097          	auipc	ra,0x1
    3202:	ce6080e7          	jalr	-794(ra) # 3ee4 <fork>
      if(pid2 == 0){
    3206:	7c050363          	beqz	a0,39cc <go+0x954>
        close(bb[1]);
        char *args[2] = { "cat", 0 };
        exec("/cat", args);
        fprintf(2, "grind: cat: not found\n");
        exit(6);
      } else if(pid2 < 0){
    320a:	08054fe3          	bltz	a0,3aa8 <go+0xa30>
        fprintf(2, "grind: fork failed\n");
        exit(7);
      }
      close(aa[0]);
    320e:	f9842503          	lw	a0,-104(s0)
    3212:	00001097          	auipc	ra,0x1
    3216:	d0a080e7          	jalr	-758(ra) # 3f1c <close>
      close(aa[1]);
    321a:	f9c42503          	lw	a0,-100(s0)
    321e:	00001097          	auipc	ra,0x1
    3222:	cfe080e7          	jalr	-770(ra) # 3f1c <close>
      close(bb[1]);
    3226:	fa442503          	lw	a0,-92(s0)
    322a:	00001097          	auipc	ra,0x1
    322e:	cf2080e7          	jalr	-782(ra) # 3f1c <close>
      char buf[4] = { 0, 0, 0, 0 };
    3232:	f8042823          	sw	zero,-112(s0)
      read(bb[0], buf+0, 1);
    3236:	4605                	li	a2,1
    3238:	f9040593          	addi	a1,s0,-112
    323c:	fa042503          	lw	a0,-96(s0)
    3240:	00001097          	auipc	ra,0x1
    3244:	ccc080e7          	jalr	-820(ra) # 3f0c <read>
      read(bb[0], buf+1, 1);
    3248:	4605                	li	a2,1
    324a:	f9140593          	addi	a1,s0,-111
    324e:	fa042503          	lw	a0,-96(s0)
    3252:	00001097          	auipc	ra,0x1
    3256:	cba080e7          	jalr	-838(ra) # 3f0c <read>
      read(bb[0], buf+2, 1);
    325a:	4605                	li	a2,1
    325c:	f9240593          	addi	a1,s0,-110
    3260:	fa042503          	lw	a0,-96(s0)
    3264:	00001097          	auipc	ra,0x1
    3268:	ca8080e7          	jalr	-856(ra) # 3f0c <read>
      close(bb[0]);
    326c:	fa042503          	lw	a0,-96(s0)
    3270:	00001097          	auipc	ra,0x1
    3274:	cac080e7          	jalr	-852(ra) # 3f1c <close>
      int st1, st2;
      wait(&st1);
    3278:	f9440513          	addi	a0,s0,-108
    327c:	00001097          	auipc	ra,0x1
    3280:	c78080e7          	jalr	-904(ra) # 3ef4 <wait>
      wait(&st2);
    3284:	fa840513          	addi	a0,s0,-88
    3288:	00001097          	auipc	ra,0x1
    328c:	c6c080e7          	jalr	-916(ra) # 3ef4 <wait>
      if(st1 != 0 || st2 != 0 || strcmp(buf, "hi\n") != 0){
    3290:	f9442783          	lw	a5,-108(s0)
    3294:	fa842703          	lw	a4,-88(s0)
    3298:	8fd9                	or	a5,a5,a4
    329a:	2781                	sext.w	a5,a5
    329c:	ef89                	bnez	a5,32b6 <go+0x23e>
    329e:	00001597          	auipc	a1,0x1
    32a2:	45a58593          	addi	a1,a1,1114 # 46f8 <malloc+0x3a6>
    32a6:	f9040513          	addi	a0,s0,-112
    32aa:	00001097          	auipc	ra,0x1
    32ae:	998080e7          	jalr	-1640(ra) # 3c42 <strcmp>
    32b2:	e60508e3          	beqz	a0,3122 <go+0xaa>
        printf("grind: exec pipeline failed %d %d \"%s\"\n", st1, st2, buf);
    32b6:	f9040693          	addi	a3,s0,-112
    32ba:	fa842603          	lw	a2,-88(s0)
    32be:	f9442583          	lw	a1,-108(s0)
    32c2:	00001517          	auipc	a0,0x1
    32c6:	43e50513          	addi	a0,a0,1086 # 4700 <malloc+0x3ae>
    32ca:	00001097          	auipc	ra,0x1
    32ce:	fca080e7          	jalr	-54(ra) # 4294 <printf>
        exit(1);
    32d2:	4505                	li	a0,1
    32d4:	00001097          	auipc	ra,0x1
    32d8:	c18080e7          	jalr	-1000(ra) # 3eec <exit>
      close(open("grindir/../grindir/../b", O_CREATE|O_RDWR));
    32dc:	20200593          	li	a1,514
    32e0:	00001517          	auipc	a0,0x1
    32e4:	1b050513          	addi	a0,a0,432 # 4490 <malloc+0x13e>
    32e8:	00001097          	auipc	ra,0x1
    32ec:	c4c080e7          	jalr	-948(ra) # 3f34 <open>
    32f0:	00001097          	auipc	ra,0x1
    32f4:	c2c080e7          	jalr	-980(ra) # 3f1c <close>
    32f8:	b52d                	j	3122 <go+0xaa>
      unlink("grindir/../a");
    32fa:	00001517          	auipc	a0,0x1
    32fe:	18650513          	addi	a0,a0,390 # 4480 <malloc+0x12e>
    3302:	00001097          	auipc	ra,0x1
    3306:	c42080e7          	jalr	-958(ra) # 3f44 <unlink>
    330a:	bd21                	j	3122 <go+0xaa>
      if(chdir("grindir") != 0){
    330c:	00001517          	auipc	a0,0x1
    3310:	13450513          	addi	a0,a0,308 # 4440 <malloc+0xee>
    3314:	00001097          	auipc	ra,0x1
    3318:	c50080e7          	jalr	-944(ra) # 3f64 <chdir>
    331c:	e115                	bnez	a0,3340 <go+0x2c8>
      unlink("../b");
    331e:	00001517          	auipc	a0,0x1
    3322:	18a50513          	addi	a0,a0,394 # 44a8 <malloc+0x156>
    3326:	00001097          	auipc	ra,0x1
    332a:	c1e080e7          	jalr	-994(ra) # 3f44 <unlink>
      chdir("/");
    332e:	00001517          	auipc	a0,0x1
    3332:	13a50513          	addi	a0,a0,314 # 4468 <malloc+0x116>
    3336:	00001097          	auipc	ra,0x1
    333a:	c2e080e7          	jalr	-978(ra) # 3f64 <chdir>
    333e:	b3d5                	j	3122 <go+0xaa>
        printf("grind: chdir grindir failed\n");
    3340:	00001517          	auipc	a0,0x1
    3344:	10850513          	addi	a0,a0,264 # 4448 <malloc+0xf6>
    3348:	00001097          	auipc	ra,0x1
    334c:	f4c080e7          	jalr	-180(ra) # 4294 <printf>
        exit(1);
    3350:	4505                	li	a0,1
    3352:	00001097          	auipc	ra,0x1
    3356:	b9a080e7          	jalr	-1126(ra) # 3eec <exit>
      close(fd);
    335a:	854a                	mv	a0,s2
    335c:	00001097          	auipc	ra,0x1
    3360:	bc0080e7          	jalr	-1088(ra) # 3f1c <close>
      fd = open("/grindir/../a", O_CREATE|O_RDWR);
    3364:	20200593          	li	a1,514
    3368:	00001517          	auipc	a0,0x1
    336c:	14850513          	addi	a0,a0,328 # 44b0 <malloc+0x15e>
    3370:	00001097          	auipc	ra,0x1
    3374:	bc4080e7          	jalr	-1084(ra) # 3f34 <open>
    3378:	892a                	mv	s2,a0
    337a:	b365                	j	3122 <go+0xaa>
      close(fd);
    337c:	854a                	mv	a0,s2
    337e:	00001097          	auipc	ra,0x1
    3382:	b9e080e7          	jalr	-1122(ra) # 3f1c <close>
      fd = open("/./grindir/./../b", O_CREATE|O_RDWR);
    3386:	20200593          	li	a1,514
    338a:	00001517          	auipc	a0,0x1
    338e:	13650513          	addi	a0,a0,310 # 44c0 <malloc+0x16e>
    3392:	00001097          	auipc	ra,0x1
    3396:	ba2080e7          	jalr	-1118(ra) # 3f34 <open>
    339a:	892a                	mv	s2,a0
    339c:	b359                	j	3122 <go+0xaa>
      write(fd, buf, sizeof(buf));
    339e:	3e700613          	li	a2,999
    33a2:	85d2                	mv	a1,s4
    33a4:	854a                	mv	a0,s2
    33a6:	00001097          	auipc	ra,0x1
    33aa:	b6e080e7          	jalr	-1170(ra) # 3f14 <write>
    33ae:	bb95                	j	3122 <go+0xaa>
      read(fd, buf, sizeof(buf));
    33b0:	3e700613          	li	a2,999
    33b4:	85d2                	mv	a1,s4
    33b6:	854a                	mv	a0,s2
    33b8:	00001097          	auipc	ra,0x1
    33bc:	b54080e7          	jalr	-1196(ra) # 3f0c <read>
    33c0:	b38d                	j	3122 <go+0xaa>
      mkdir("grindir/../a");
    33c2:	00001517          	auipc	a0,0x1
    33c6:	0be50513          	addi	a0,a0,190 # 4480 <malloc+0x12e>
    33ca:	00001097          	auipc	ra,0x1
    33ce:	b92080e7          	jalr	-1134(ra) # 3f5c <mkdir>
      close(open("a/../a/./a", O_CREATE|O_RDWR));
    33d2:	20200593          	li	a1,514
    33d6:	00001517          	auipc	a0,0x1
    33da:	10250513          	addi	a0,a0,258 # 44d8 <malloc+0x186>
    33de:	00001097          	auipc	ra,0x1
    33e2:	b56080e7          	jalr	-1194(ra) # 3f34 <open>
    33e6:	00001097          	auipc	ra,0x1
    33ea:	b36080e7          	jalr	-1226(ra) # 3f1c <close>
      unlink("a/a");
    33ee:	00001517          	auipc	a0,0x1
    33f2:	0fa50513          	addi	a0,a0,250 # 44e8 <malloc+0x196>
    33f6:	00001097          	auipc	ra,0x1
    33fa:	b4e080e7          	jalr	-1202(ra) # 3f44 <unlink>
    33fe:	b315                	j	3122 <go+0xaa>
      mkdir("/../b");
    3400:	00001517          	auipc	a0,0x1
    3404:	0f050513          	addi	a0,a0,240 # 44f0 <malloc+0x19e>
    3408:	00001097          	auipc	ra,0x1
    340c:	b54080e7          	jalr	-1196(ra) # 3f5c <mkdir>
      close(open("grindir/../b/b", O_CREATE|O_RDWR));
    3410:	20200593          	li	a1,514
    3414:	00001517          	auipc	a0,0x1
    3418:	0e450513          	addi	a0,a0,228 # 44f8 <malloc+0x1a6>
    341c:	00001097          	auipc	ra,0x1
    3420:	b18080e7          	jalr	-1256(ra) # 3f34 <open>
    3424:	00001097          	auipc	ra,0x1
    3428:	af8080e7          	jalr	-1288(ra) # 3f1c <close>
      unlink("b/b");
    342c:	00001517          	auipc	a0,0x1
    3430:	0dc50513          	addi	a0,a0,220 # 4508 <malloc+0x1b6>
    3434:	00001097          	auipc	ra,0x1
    3438:	b10080e7          	jalr	-1264(ra) # 3f44 <unlink>
    343c:	b1dd                	j	3122 <go+0xaa>
      unlink("b");
    343e:	00001517          	auipc	a0,0x1
    3442:	09250513          	addi	a0,a0,146 # 44d0 <malloc+0x17e>
    3446:	00001097          	auipc	ra,0x1
    344a:	afe080e7          	jalr	-1282(ra) # 3f44 <unlink>
      link("../grindir/./../a", "../b");
    344e:	00001597          	auipc	a1,0x1
    3452:	05a58593          	addi	a1,a1,90 # 44a8 <malloc+0x156>
    3456:	00001517          	auipc	a0,0x1
    345a:	0ba50513          	addi	a0,a0,186 # 4510 <malloc+0x1be>
    345e:	00001097          	auipc	ra,0x1
    3462:	af6080e7          	jalr	-1290(ra) # 3f54 <link>
    3466:	b975                	j	3122 <go+0xaa>
      unlink("../grindir/../a");
    3468:	00001517          	auipc	a0,0x1
    346c:	0c050513          	addi	a0,a0,192 # 4528 <malloc+0x1d6>
    3470:	00001097          	auipc	ra,0x1
    3474:	ad4080e7          	jalr	-1324(ra) # 3f44 <unlink>
      link(".././b", "/grindir/../a");
    3478:	00001597          	auipc	a1,0x1
    347c:	03858593          	addi	a1,a1,56 # 44b0 <malloc+0x15e>
    3480:	00001517          	auipc	a0,0x1
    3484:	0b850513          	addi	a0,a0,184 # 4538 <malloc+0x1e6>
    3488:	00001097          	auipc	ra,0x1
    348c:	acc080e7          	jalr	-1332(ra) # 3f54 <link>
    3490:	b949                	j	3122 <go+0xaa>
      int pid = fork();
    3492:	00001097          	auipc	ra,0x1
    3496:	a52080e7          	jalr	-1454(ra) # 3ee4 <fork>
      if(pid == 0){
    349a:	c909                	beqz	a0,34ac <go+0x434>
      } else if(pid < 0){
    349c:	00054c63          	bltz	a0,34b4 <go+0x43c>
      wait(0);
    34a0:	4501                	li	a0,0
    34a2:	00001097          	auipc	ra,0x1
    34a6:	a52080e7          	jalr	-1454(ra) # 3ef4 <wait>
    34aa:	b9a5                	j	3122 <go+0xaa>
        exit(0);
    34ac:	00001097          	auipc	ra,0x1
    34b0:	a40080e7          	jalr	-1472(ra) # 3eec <exit>
        printf("grind: fork failed\n");
    34b4:	00001517          	auipc	a0,0x1
    34b8:	08c50513          	addi	a0,a0,140 # 4540 <malloc+0x1ee>
    34bc:	00001097          	auipc	ra,0x1
    34c0:	dd8080e7          	jalr	-552(ra) # 4294 <printf>
        exit(1);
    34c4:	4505                	li	a0,1
    34c6:	00001097          	auipc	ra,0x1
    34ca:	a26080e7          	jalr	-1498(ra) # 3eec <exit>
      int pid = fork();
    34ce:	00001097          	auipc	ra,0x1
    34d2:	a16080e7          	jalr	-1514(ra) # 3ee4 <fork>
      if(pid == 0){
    34d6:	c909                	beqz	a0,34e8 <go+0x470>
      } else if(pid < 0){
    34d8:	02054563          	bltz	a0,3502 <go+0x48a>
      wait(0);
    34dc:	4501                	li	a0,0
    34de:	00001097          	auipc	ra,0x1
    34e2:	a16080e7          	jalr	-1514(ra) # 3ef4 <wait>
    34e6:	b935                	j	3122 <go+0xaa>
        fork();
    34e8:	00001097          	auipc	ra,0x1
    34ec:	9fc080e7          	jalr	-1540(ra) # 3ee4 <fork>
        fork();
    34f0:	00001097          	auipc	ra,0x1
    34f4:	9f4080e7          	jalr	-1548(ra) # 3ee4 <fork>
        exit(0);
    34f8:	4501                	li	a0,0
    34fa:	00001097          	auipc	ra,0x1
    34fe:	9f2080e7          	jalr	-1550(ra) # 3eec <exit>
        printf("grind: fork failed\n");
    3502:	00001517          	auipc	a0,0x1
    3506:	03e50513          	addi	a0,a0,62 # 4540 <malloc+0x1ee>
    350a:	00001097          	auipc	ra,0x1
    350e:	d8a080e7          	jalr	-630(ra) # 4294 <printf>
        exit(1);
    3512:	4505                	li	a0,1
    3514:	00001097          	auipc	ra,0x1
    3518:	9d8080e7          	jalr	-1576(ra) # 3eec <exit>
      sbrk(6011);
    351c:	6505                	lui	a0,0x1
    351e:	77b50513          	addi	a0,a0,1915 # 177b <do_rand-0x1885>
    3522:	00001097          	auipc	ra,0x1
    3526:	a5a080e7          	jalr	-1446(ra) # 3f7c <sbrk>
    352a:	bee5                	j	3122 <go+0xaa>
      if(sbrk(0) > break0)
    352c:	4501                	li	a0,0
    352e:	00001097          	auipc	ra,0x1
    3532:	a4e080e7          	jalr	-1458(ra) # 3f7c <sbrk>
    3536:	beaaf6e3          	bgeu	s5,a0,3122 <go+0xaa>
        sbrk(-(sbrk(0) - break0));
    353a:	4501                	li	a0,0
    353c:	00001097          	auipc	ra,0x1
    3540:	a40080e7          	jalr	-1472(ra) # 3f7c <sbrk>
    3544:	40aa853b          	subw	a0,s5,a0
    3548:	00001097          	auipc	ra,0x1
    354c:	a34080e7          	jalr	-1484(ra) # 3f7c <sbrk>
    3550:	bec9                	j	3122 <go+0xaa>
      int pid = fork();
    3552:	00001097          	auipc	ra,0x1
    3556:	992080e7          	jalr	-1646(ra) # 3ee4 <fork>
    355a:	8b2a                	mv	s6,a0
      if(pid == 0){
    355c:	c51d                	beqz	a0,358a <go+0x512>
      } else if(pid < 0){
    355e:	04054963          	bltz	a0,35b0 <go+0x538>
      if(chdir("../grindir/..") != 0){
    3562:	00001517          	auipc	a0,0x1
    3566:	ff650513          	addi	a0,a0,-10 # 4558 <malloc+0x206>
    356a:	00001097          	auipc	ra,0x1
    356e:	9fa080e7          	jalr	-1542(ra) # 3f64 <chdir>
    3572:	ed21                	bnez	a0,35ca <go+0x552>
      kill(pid);
    3574:	855a                	mv	a0,s6
    3576:	00001097          	auipc	ra,0x1
    357a:	9ae080e7          	jalr	-1618(ra) # 3f24 <kill>
      wait(0);
    357e:	4501                	li	a0,0
    3580:	00001097          	auipc	ra,0x1
    3584:	974080e7          	jalr	-1676(ra) # 3ef4 <wait>
    3588:	be69                	j	3122 <go+0xaa>
        close(open("a", O_CREATE|O_RDWR));
    358a:	20200593          	li	a1,514
    358e:	00001517          	auipc	a0,0x1
    3592:	f9250513          	addi	a0,a0,-110 # 4520 <malloc+0x1ce>
    3596:	00001097          	auipc	ra,0x1
    359a:	99e080e7          	jalr	-1634(ra) # 3f34 <open>
    359e:	00001097          	auipc	ra,0x1
    35a2:	97e080e7          	jalr	-1666(ra) # 3f1c <close>
        exit(0);
    35a6:	4501                	li	a0,0
    35a8:	00001097          	auipc	ra,0x1
    35ac:	944080e7          	jalr	-1724(ra) # 3eec <exit>
        printf("grind: fork failed\n");
    35b0:	00001517          	auipc	a0,0x1
    35b4:	f9050513          	addi	a0,a0,-112 # 4540 <malloc+0x1ee>
    35b8:	00001097          	auipc	ra,0x1
    35bc:	cdc080e7          	jalr	-804(ra) # 4294 <printf>
        exit(1);
    35c0:	4505                	li	a0,1
    35c2:	00001097          	auipc	ra,0x1
    35c6:	92a080e7          	jalr	-1750(ra) # 3eec <exit>
        printf("grind: chdir failed\n");
    35ca:	00001517          	auipc	a0,0x1
    35ce:	f9e50513          	addi	a0,a0,-98 # 4568 <malloc+0x216>
    35d2:	00001097          	auipc	ra,0x1
    35d6:	cc2080e7          	jalr	-830(ra) # 4294 <printf>
        exit(1);
    35da:	4505                	li	a0,1
    35dc:	00001097          	auipc	ra,0x1
    35e0:	910080e7          	jalr	-1776(ra) # 3eec <exit>
      int pid = fork();
    35e4:	00001097          	auipc	ra,0x1
    35e8:	900080e7          	jalr	-1792(ra) # 3ee4 <fork>
      if(pid == 0){
    35ec:	c909                	beqz	a0,35fe <go+0x586>
      } else if(pid < 0){
    35ee:	02054563          	bltz	a0,3618 <go+0x5a0>
      wait(0);
    35f2:	4501                	li	a0,0
    35f4:	00001097          	auipc	ra,0x1
    35f8:	900080e7          	jalr	-1792(ra) # 3ef4 <wait>
    35fc:	b61d                	j	3122 <go+0xaa>
        kill(getpid());
    35fe:	00001097          	auipc	ra,0x1
    3602:	976080e7          	jalr	-1674(ra) # 3f74 <getpid>
    3606:	00001097          	auipc	ra,0x1
    360a:	91e080e7          	jalr	-1762(ra) # 3f24 <kill>
        exit(0);
    360e:	4501                	li	a0,0
    3610:	00001097          	auipc	ra,0x1
    3614:	8dc080e7          	jalr	-1828(ra) # 3eec <exit>
        printf("grind: fork failed\n");
    3618:	00001517          	auipc	a0,0x1
    361c:	f2850513          	addi	a0,a0,-216 # 4540 <malloc+0x1ee>
    3620:	00001097          	auipc	ra,0x1
    3624:	c74080e7          	jalr	-908(ra) # 4294 <printf>
        exit(1);
    3628:	4505                	li	a0,1
    362a:	00001097          	auipc	ra,0x1
    362e:	8c2080e7          	jalr	-1854(ra) # 3eec <exit>
      if(pipe(fds) < 0){
    3632:	fa840513          	addi	a0,s0,-88
    3636:	00001097          	auipc	ra,0x1
    363a:	8ce080e7          	jalr	-1842(ra) # 3f04 <pipe>
    363e:	02054b63          	bltz	a0,3674 <go+0x5fc>
      int pid = fork();
    3642:	00001097          	auipc	ra,0x1
    3646:	8a2080e7          	jalr	-1886(ra) # 3ee4 <fork>
      if(pid == 0){
    364a:	c131                	beqz	a0,368e <go+0x616>
      } else if(pid < 0){
    364c:	0a054a63          	bltz	a0,3700 <go+0x688>
      close(fds[0]);
    3650:	fa842503          	lw	a0,-88(s0)
    3654:	00001097          	auipc	ra,0x1
    3658:	8c8080e7          	jalr	-1848(ra) # 3f1c <close>
      close(fds[1]);
    365c:	fac42503          	lw	a0,-84(s0)
    3660:	00001097          	auipc	ra,0x1
    3664:	8bc080e7          	jalr	-1860(ra) # 3f1c <close>
      wait(0);
    3668:	4501                	li	a0,0
    366a:	00001097          	auipc	ra,0x1
    366e:	88a080e7          	jalr	-1910(ra) # 3ef4 <wait>
    3672:	bc45                	j	3122 <go+0xaa>
        printf("grind: pipe failed\n");
    3674:	00001517          	auipc	a0,0x1
    3678:	f0c50513          	addi	a0,a0,-244 # 4580 <malloc+0x22e>
    367c:	00001097          	auipc	ra,0x1
    3680:	c18080e7          	jalr	-1000(ra) # 4294 <printf>
        exit(1);
    3684:	4505                	li	a0,1
    3686:	00001097          	auipc	ra,0x1
    368a:	866080e7          	jalr	-1946(ra) # 3eec <exit>
        fork();
    368e:	00001097          	auipc	ra,0x1
    3692:	856080e7          	jalr	-1962(ra) # 3ee4 <fork>
        fork();
    3696:	00001097          	auipc	ra,0x1
    369a:	84e080e7          	jalr	-1970(ra) # 3ee4 <fork>
        if(write(fds[1], "x", 1) != 1)
    369e:	4605                	li	a2,1
    36a0:	00001597          	auipc	a1,0x1
    36a4:	ef858593          	addi	a1,a1,-264 # 4598 <malloc+0x246>
    36a8:	fac42503          	lw	a0,-84(s0)
    36ac:	00001097          	auipc	ra,0x1
    36b0:	868080e7          	jalr	-1944(ra) # 3f14 <write>
    36b4:	4785                	li	a5,1
    36b6:	02f51363          	bne	a0,a5,36dc <go+0x664>
        if(read(fds[0], &c, 1) != 1)
    36ba:	4605                	li	a2,1
    36bc:	fa040593          	addi	a1,s0,-96
    36c0:	fa842503          	lw	a0,-88(s0)
    36c4:	00001097          	auipc	ra,0x1
    36c8:	848080e7          	jalr	-1976(ra) # 3f0c <read>
    36cc:	4785                	li	a5,1
    36ce:	02f51063          	bne	a0,a5,36ee <go+0x676>
        exit(0);
    36d2:	4501                	li	a0,0
    36d4:	00001097          	auipc	ra,0x1
    36d8:	818080e7          	jalr	-2024(ra) # 3eec <exit>
          printf("grind: pipe write failed\n");
    36dc:	00001517          	auipc	a0,0x1
    36e0:	ec450513          	addi	a0,a0,-316 # 45a0 <malloc+0x24e>
    36e4:	00001097          	auipc	ra,0x1
    36e8:	bb0080e7          	jalr	-1104(ra) # 4294 <printf>
    36ec:	b7f9                	j	36ba <go+0x642>
          printf("grind: pipe read failed\n");
    36ee:	00001517          	auipc	a0,0x1
    36f2:	ed250513          	addi	a0,a0,-302 # 45c0 <malloc+0x26e>
    36f6:	00001097          	auipc	ra,0x1
    36fa:	b9e080e7          	jalr	-1122(ra) # 4294 <printf>
    36fe:	bfd1                	j	36d2 <go+0x65a>
        printf("grind: fork failed\n");
    3700:	00001517          	auipc	a0,0x1
    3704:	e4050513          	addi	a0,a0,-448 # 4540 <malloc+0x1ee>
    3708:	00001097          	auipc	ra,0x1
    370c:	b8c080e7          	jalr	-1140(ra) # 4294 <printf>
        exit(1);
    3710:	4505                	li	a0,1
    3712:	00000097          	auipc	ra,0x0
    3716:	7da080e7          	jalr	2010(ra) # 3eec <exit>
      int pid = fork();
    371a:	00000097          	auipc	ra,0x0
    371e:	7ca080e7          	jalr	1994(ra) # 3ee4 <fork>
      if(pid == 0){
    3722:	c909                	beqz	a0,3734 <go+0x6bc>
      } else if(pid < 0){
    3724:	06054f63          	bltz	a0,37a2 <go+0x72a>
      wait(0);
    3728:	4501                	li	a0,0
    372a:	00000097          	auipc	ra,0x0
    372e:	7ca080e7          	jalr	1994(ra) # 3ef4 <wait>
    3732:	bac5                	j	3122 <go+0xaa>
        unlink("a");
    3734:	00001517          	auipc	a0,0x1
    3738:	dec50513          	addi	a0,a0,-532 # 4520 <malloc+0x1ce>
    373c:	00001097          	auipc	ra,0x1
    3740:	808080e7          	jalr	-2040(ra) # 3f44 <unlink>
        mkdir("a");
    3744:	00001517          	auipc	a0,0x1
    3748:	ddc50513          	addi	a0,a0,-548 # 4520 <malloc+0x1ce>
    374c:	00001097          	auipc	ra,0x1
    3750:	810080e7          	jalr	-2032(ra) # 3f5c <mkdir>
        chdir("a");
    3754:	00001517          	auipc	a0,0x1
    3758:	dcc50513          	addi	a0,a0,-564 # 4520 <malloc+0x1ce>
    375c:	00001097          	auipc	ra,0x1
    3760:	808080e7          	jalr	-2040(ra) # 3f64 <chdir>
        unlink("../a");
    3764:	00001517          	auipc	a0,0x1
    3768:	d2450513          	addi	a0,a0,-732 # 4488 <malloc+0x136>
    376c:	00000097          	auipc	ra,0x0
    3770:	7d8080e7          	jalr	2008(ra) # 3f44 <unlink>
        fd = open("x", O_CREATE|O_RDWR);
    3774:	20200593          	li	a1,514
    3778:	00001517          	auipc	a0,0x1
    377c:	e2050513          	addi	a0,a0,-480 # 4598 <malloc+0x246>
    3780:	00000097          	auipc	ra,0x0
    3784:	7b4080e7          	jalr	1972(ra) # 3f34 <open>
        unlink("x");
    3788:	00001517          	auipc	a0,0x1
    378c:	e1050513          	addi	a0,a0,-496 # 4598 <malloc+0x246>
    3790:	00000097          	auipc	ra,0x0
    3794:	7b4080e7          	jalr	1972(ra) # 3f44 <unlink>
        exit(0);
    3798:	4501                	li	a0,0
    379a:	00000097          	auipc	ra,0x0
    379e:	752080e7          	jalr	1874(ra) # 3eec <exit>
        printf("grind: fork failed\n");
    37a2:	00001517          	auipc	a0,0x1
    37a6:	d9e50513          	addi	a0,a0,-610 # 4540 <malloc+0x1ee>
    37aa:	00001097          	auipc	ra,0x1
    37ae:	aea080e7          	jalr	-1302(ra) # 4294 <printf>
        exit(1);
    37b2:	4505                	li	a0,1
    37b4:	00000097          	auipc	ra,0x0
    37b8:	738080e7          	jalr	1848(ra) # 3eec <exit>
      unlink("c");
    37bc:	00001517          	auipc	a0,0x1
    37c0:	e2450513          	addi	a0,a0,-476 # 45e0 <malloc+0x28e>
    37c4:	00000097          	auipc	ra,0x0
    37c8:	780080e7          	jalr	1920(ra) # 3f44 <unlink>
      int fd1 = open("c", O_CREATE|O_RDWR);
    37cc:	20200593          	li	a1,514
    37d0:	00001517          	auipc	a0,0x1
    37d4:	e1050513          	addi	a0,a0,-496 # 45e0 <malloc+0x28e>
    37d8:	00000097          	auipc	ra,0x0
    37dc:	75c080e7          	jalr	1884(ra) # 3f34 <open>
    37e0:	8b2a                	mv	s6,a0
      if(fd1 < 0){
    37e2:	04054f63          	bltz	a0,3840 <go+0x7c8>
      if(write(fd1, "x", 1) != 1){
    37e6:	4605                	li	a2,1
    37e8:	00001597          	auipc	a1,0x1
    37ec:	db058593          	addi	a1,a1,-592 # 4598 <malloc+0x246>
    37f0:	00000097          	auipc	ra,0x0
    37f4:	724080e7          	jalr	1828(ra) # 3f14 <write>
    37f8:	4785                	li	a5,1
    37fa:	06f51063          	bne	a0,a5,385a <go+0x7e2>
      if(fstat(fd1, &st) != 0){
    37fe:	fa840593          	addi	a1,s0,-88
    3802:	855a                	mv	a0,s6
    3804:	00000097          	auipc	ra,0x0
    3808:	748080e7          	jalr	1864(ra) # 3f4c <fstat>
    380c:	e525                	bnez	a0,3874 <go+0x7fc>
      if(st.size != 1){
    380e:	fb843583          	ld	a1,-72(s0)
    3812:	4785                	li	a5,1
    3814:	06f59d63          	bne	a1,a5,388e <go+0x816>
      if(st.ino > 200){
    3818:	fac42583          	lw	a1,-84(s0)
    381c:	0c800793          	li	a5,200
    3820:	08b7e563          	bltu	a5,a1,38aa <go+0x832>
      close(fd1);
    3824:	855a                	mv	a0,s6
    3826:	00000097          	auipc	ra,0x0
    382a:	6f6080e7          	jalr	1782(ra) # 3f1c <close>
      unlink("c");
    382e:	00001517          	auipc	a0,0x1
    3832:	db250513          	addi	a0,a0,-590 # 45e0 <malloc+0x28e>
    3836:	00000097          	auipc	ra,0x0
    383a:	70e080e7          	jalr	1806(ra) # 3f44 <unlink>
    383e:	b0d5                	j	3122 <go+0xaa>
        printf("grind: create c failed\n");
    3840:	00001517          	auipc	a0,0x1
    3844:	da850513          	addi	a0,a0,-600 # 45e8 <malloc+0x296>
    3848:	00001097          	auipc	ra,0x1
    384c:	a4c080e7          	jalr	-1460(ra) # 4294 <printf>
        exit(1);
    3850:	4505                	li	a0,1
    3852:	00000097          	auipc	ra,0x0
    3856:	69a080e7          	jalr	1690(ra) # 3eec <exit>
        printf("grind: write c failed\n");
    385a:	00001517          	auipc	a0,0x1
    385e:	da650513          	addi	a0,a0,-602 # 4600 <malloc+0x2ae>
    3862:	00001097          	auipc	ra,0x1
    3866:	a32080e7          	jalr	-1486(ra) # 4294 <printf>
        exit(1);
    386a:	4505                	li	a0,1
    386c:	00000097          	auipc	ra,0x0
    3870:	680080e7          	jalr	1664(ra) # 3eec <exit>
        printf("grind: fstat failed\n");
    3874:	00001517          	auipc	a0,0x1
    3878:	da450513          	addi	a0,a0,-604 # 4618 <malloc+0x2c6>
    387c:	00001097          	auipc	ra,0x1
    3880:	a18080e7          	jalr	-1512(ra) # 4294 <printf>
        exit(1);
    3884:	4505                	li	a0,1
    3886:	00000097          	auipc	ra,0x0
    388a:	666080e7          	jalr	1638(ra) # 3eec <exit>
        printf("grind: fstat reports wrong size %d\n", (int)st.size);
    388e:	2581                	sext.w	a1,a1
    3890:	00001517          	auipc	a0,0x1
    3894:	da050513          	addi	a0,a0,-608 # 4630 <malloc+0x2de>
    3898:	00001097          	auipc	ra,0x1
    389c:	9fc080e7          	jalr	-1540(ra) # 4294 <printf>
        exit(1);
    38a0:	4505                	li	a0,1
    38a2:	00000097          	auipc	ra,0x0
    38a6:	64a080e7          	jalr	1610(ra) # 3eec <exit>
        printf("grind: fstat reports crazy i-number %d\n", st.ino);
    38aa:	00001517          	auipc	a0,0x1
    38ae:	dae50513          	addi	a0,a0,-594 # 4658 <malloc+0x306>
    38b2:	00001097          	auipc	ra,0x1
    38b6:	9e2080e7          	jalr	-1566(ra) # 4294 <printf>
        exit(1);
    38ba:	4505                	li	a0,1
    38bc:	00000097          	auipc	ra,0x0
    38c0:	630080e7          	jalr	1584(ra) # 3eec <exit>
        fprintf(2, "grind: pipe failed\n");
    38c4:	00001597          	auipc	a1,0x1
    38c8:	cbc58593          	addi	a1,a1,-836 # 4580 <malloc+0x22e>
    38cc:	4509                	li	a0,2
    38ce:	00001097          	auipc	ra,0x1
    38d2:	998080e7          	jalr	-1640(ra) # 4266 <fprintf>
        exit(1);
    38d6:	4505                	li	a0,1
    38d8:	00000097          	auipc	ra,0x0
    38dc:	614080e7          	jalr	1556(ra) # 3eec <exit>
        fprintf(2, "grind: pipe failed\n");
    38e0:	00001597          	auipc	a1,0x1
    38e4:	ca058593          	addi	a1,a1,-864 # 4580 <malloc+0x22e>
    38e8:	4509                	li	a0,2
    38ea:	00001097          	auipc	ra,0x1
    38ee:	97c080e7          	jalr	-1668(ra) # 4266 <fprintf>
        exit(1);
    38f2:	4505                	li	a0,1
    38f4:	00000097          	auipc	ra,0x0
    38f8:	5f8080e7          	jalr	1528(ra) # 3eec <exit>
        close(bb[0]);
    38fc:	fa042503          	lw	a0,-96(s0)
    3900:	00000097          	auipc	ra,0x0
    3904:	61c080e7          	jalr	1564(ra) # 3f1c <close>
        close(bb[1]);
    3908:	fa442503          	lw	a0,-92(s0)
    390c:	00000097          	auipc	ra,0x0
    3910:	610080e7          	jalr	1552(ra) # 3f1c <close>
        close(aa[0]);
    3914:	f9842503          	lw	a0,-104(s0)
    3918:	00000097          	auipc	ra,0x0
    391c:	604080e7          	jalr	1540(ra) # 3f1c <close>
        close(1);
    3920:	4505                	li	a0,1
    3922:	00000097          	auipc	ra,0x0
    3926:	5fa080e7          	jalr	1530(ra) # 3f1c <close>
        if(dup(aa[1]) != 1){
    392a:	f9c42503          	lw	a0,-100(s0)
    392e:	00000097          	auipc	ra,0x0
    3932:	63e080e7          	jalr	1598(ra) # 3f6c <dup>
    3936:	4785                	li	a5,1
    3938:	02f50063          	beq	a0,a5,3958 <go+0x8e0>
          fprintf(2, "grind: dup failed\n");
    393c:	00001597          	auipc	a1,0x1
    3940:	d4458593          	addi	a1,a1,-700 # 4680 <malloc+0x32e>
    3944:	4509                	li	a0,2
    3946:	00001097          	auipc	ra,0x1
    394a:	920080e7          	jalr	-1760(ra) # 4266 <fprintf>
          exit(1);
    394e:	4505                	li	a0,1
    3950:	00000097          	auipc	ra,0x0
    3954:	59c080e7          	jalr	1436(ra) # 3eec <exit>
        close(aa[1]);
    3958:	f9c42503          	lw	a0,-100(s0)
    395c:	00000097          	auipc	ra,0x0
    3960:	5c0080e7          	jalr	1472(ra) # 3f1c <close>
        char *args[3] = { "echo", "hi", 0 };
    3964:	00001797          	auipc	a5,0x1
    3968:	d3478793          	addi	a5,a5,-716 # 4698 <malloc+0x346>
    396c:	faf43423          	sd	a5,-88(s0)
    3970:	00001797          	auipc	a5,0x1
    3974:	d3078793          	addi	a5,a5,-720 # 46a0 <malloc+0x34e>
    3978:	faf43823          	sd	a5,-80(s0)
    397c:	fa043c23          	sd	zero,-72(s0)
        exec("grindir/../echo", args);
    3980:	fa840593          	addi	a1,s0,-88
    3984:	00001517          	auipc	a0,0x1
    3988:	d2450513          	addi	a0,a0,-732 # 46a8 <malloc+0x356>
    398c:	00000097          	auipc	ra,0x0
    3990:	5a0080e7          	jalr	1440(ra) # 3f2c <exec>
        fprintf(2, "grind: echo: not found\n");
    3994:	00001597          	auipc	a1,0x1
    3998:	d2458593          	addi	a1,a1,-732 # 46b8 <malloc+0x366>
    399c:	4509                	li	a0,2
    399e:	00001097          	auipc	ra,0x1
    39a2:	8c8080e7          	jalr	-1848(ra) # 4266 <fprintf>
        exit(2);
    39a6:	4509                	li	a0,2
    39a8:	00000097          	auipc	ra,0x0
    39ac:	544080e7          	jalr	1348(ra) # 3eec <exit>
        fprintf(2, "grind: fork failed\n");
    39b0:	00001597          	auipc	a1,0x1
    39b4:	b9058593          	addi	a1,a1,-1136 # 4540 <malloc+0x1ee>
    39b8:	4509                	li	a0,2
    39ba:	00001097          	auipc	ra,0x1
    39be:	8ac080e7          	jalr	-1876(ra) # 4266 <fprintf>
        exit(3);
    39c2:	450d                	li	a0,3
    39c4:	00000097          	auipc	ra,0x0
    39c8:	528080e7          	jalr	1320(ra) # 3eec <exit>
        close(aa[1]);
    39cc:	f9c42503          	lw	a0,-100(s0)
    39d0:	00000097          	auipc	ra,0x0
    39d4:	54c080e7          	jalr	1356(ra) # 3f1c <close>
        close(bb[0]);
    39d8:	fa042503          	lw	a0,-96(s0)
    39dc:	00000097          	auipc	ra,0x0
    39e0:	540080e7          	jalr	1344(ra) # 3f1c <close>
        close(0);
    39e4:	4501                	li	a0,0
    39e6:	00000097          	auipc	ra,0x0
    39ea:	536080e7          	jalr	1334(ra) # 3f1c <close>
        if(dup(aa[0]) != 0){
    39ee:	f9842503          	lw	a0,-104(s0)
    39f2:	00000097          	auipc	ra,0x0
    39f6:	57a080e7          	jalr	1402(ra) # 3f6c <dup>
    39fa:	cd19                	beqz	a0,3a18 <go+0x9a0>
          fprintf(2, "grind: dup failed\n");
    39fc:	00001597          	auipc	a1,0x1
    3a00:	c8458593          	addi	a1,a1,-892 # 4680 <malloc+0x32e>
    3a04:	4509                	li	a0,2
    3a06:	00001097          	auipc	ra,0x1
    3a0a:	860080e7          	jalr	-1952(ra) # 4266 <fprintf>
          exit(4);
    3a0e:	4511                	li	a0,4
    3a10:	00000097          	auipc	ra,0x0
    3a14:	4dc080e7          	jalr	1244(ra) # 3eec <exit>
        close(aa[0]);
    3a18:	f9842503          	lw	a0,-104(s0)
    3a1c:	00000097          	auipc	ra,0x0
    3a20:	500080e7          	jalr	1280(ra) # 3f1c <close>
        close(1);
    3a24:	4505                	li	a0,1
    3a26:	00000097          	auipc	ra,0x0
    3a2a:	4f6080e7          	jalr	1270(ra) # 3f1c <close>
        if(dup(bb[1]) != 1){
    3a2e:	fa442503          	lw	a0,-92(s0)
    3a32:	00000097          	auipc	ra,0x0
    3a36:	53a080e7          	jalr	1338(ra) # 3f6c <dup>
    3a3a:	4785                	li	a5,1
    3a3c:	02f50063          	beq	a0,a5,3a5c <go+0x9e4>
          fprintf(2, "grind: dup failed\n");
    3a40:	00001597          	auipc	a1,0x1
    3a44:	c4058593          	addi	a1,a1,-960 # 4680 <malloc+0x32e>
    3a48:	4509                	li	a0,2
    3a4a:	00001097          	auipc	ra,0x1
    3a4e:	81c080e7          	jalr	-2020(ra) # 4266 <fprintf>
          exit(5);
    3a52:	4515                	li	a0,5
    3a54:	00000097          	auipc	ra,0x0
    3a58:	498080e7          	jalr	1176(ra) # 3eec <exit>
        close(bb[1]);
    3a5c:	fa442503          	lw	a0,-92(s0)
    3a60:	00000097          	auipc	ra,0x0
    3a64:	4bc080e7          	jalr	1212(ra) # 3f1c <close>
        char *args[2] = { "cat", 0 };
    3a68:	00001797          	auipc	a5,0x1
    3a6c:	c6878793          	addi	a5,a5,-920 # 46d0 <malloc+0x37e>
    3a70:	faf43423          	sd	a5,-88(s0)
    3a74:	fa043823          	sd	zero,-80(s0)
        exec("/cat", args);
    3a78:	fa840593          	addi	a1,s0,-88
    3a7c:	00001517          	auipc	a0,0x1
    3a80:	c5c50513          	addi	a0,a0,-932 # 46d8 <malloc+0x386>
    3a84:	00000097          	auipc	ra,0x0
    3a88:	4a8080e7          	jalr	1192(ra) # 3f2c <exec>
        fprintf(2, "grind: cat: not found\n");
    3a8c:	00001597          	auipc	a1,0x1
    3a90:	c5458593          	addi	a1,a1,-940 # 46e0 <malloc+0x38e>
    3a94:	4509                	li	a0,2
    3a96:	00000097          	auipc	ra,0x0
    3a9a:	7d0080e7          	jalr	2000(ra) # 4266 <fprintf>
        exit(6);
    3a9e:	4519                	li	a0,6
    3aa0:	00000097          	auipc	ra,0x0
    3aa4:	44c080e7          	jalr	1100(ra) # 3eec <exit>
        fprintf(2, "grind: fork failed\n");
    3aa8:	00001597          	auipc	a1,0x1
    3aac:	a9858593          	addi	a1,a1,-1384 # 4540 <malloc+0x1ee>
    3ab0:	4509                	li	a0,2
    3ab2:	00000097          	auipc	ra,0x0
    3ab6:	7b4080e7          	jalr	1972(ra) # 4266 <fprintf>
        exit(7);
    3aba:	451d                	li	a0,7
    3abc:	00000097          	auipc	ra,0x0
    3ac0:	430080e7          	jalr	1072(ra) # 3eec <exit>

0000000000003ac4 <iter>:
  }
}

void
iter()
{
    3ac4:	7179                	addi	sp,sp,-48
    3ac6:	f406                	sd	ra,40(sp)
    3ac8:	f022                	sd	s0,32(sp)
    3aca:	ec26                	sd	s1,24(sp)
    3acc:	e84a                	sd	s2,16(sp)
    3ace:	1800                	addi	s0,sp,48
  unlink("a");
    3ad0:	00001517          	auipc	a0,0x1
    3ad4:	a5050513          	addi	a0,a0,-1456 # 4520 <malloc+0x1ce>
    3ad8:	00000097          	auipc	ra,0x0
    3adc:	46c080e7          	jalr	1132(ra) # 3f44 <unlink>
  unlink("b");
    3ae0:	00001517          	auipc	a0,0x1
    3ae4:	9f050513          	addi	a0,a0,-1552 # 44d0 <malloc+0x17e>
    3ae8:	00000097          	auipc	ra,0x0
    3aec:	45c080e7          	jalr	1116(ra) # 3f44 <unlink>
  
  int pid1 = fork();
    3af0:	00000097          	auipc	ra,0x0
    3af4:	3f4080e7          	jalr	1012(ra) # 3ee4 <fork>
  if(pid1 < 0){
    3af8:	02054163          	bltz	a0,3b1a <iter+0x56>
    3afc:	84aa                	mv	s1,a0
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid1 == 0){
    3afe:	e91d                	bnez	a0,3b34 <iter+0x70>
    rand_next ^= 31;
    3b00:	00001717          	auipc	a4,0x1
    3b04:	50070713          	addi	a4,a4,1280 # 5000 <rand_next>
    3b08:	631c                	ld	a5,0(a4)
    3b0a:	01f7c793          	xori	a5,a5,31
    3b0e:	e31c                	sd	a5,0(a4)
    go(0);
    3b10:	4501                	li	a0,0
    3b12:	fffff097          	auipc	ra,0xfffff
    3b16:	566080e7          	jalr	1382(ra) # 3078 <go>
    printf("grind: fork failed\n");
    3b1a:	00001517          	auipc	a0,0x1
    3b1e:	a2650513          	addi	a0,a0,-1498 # 4540 <malloc+0x1ee>
    3b22:	00000097          	auipc	ra,0x0
    3b26:	772080e7          	jalr	1906(ra) # 4294 <printf>
    exit(1);
    3b2a:	4505                	li	a0,1
    3b2c:	00000097          	auipc	ra,0x0
    3b30:	3c0080e7          	jalr	960(ra) # 3eec <exit>
    exit(0);
  }

  int pid2 = fork();
    3b34:	00000097          	auipc	ra,0x0
    3b38:	3b0080e7          	jalr	944(ra) # 3ee4 <fork>
    3b3c:	892a                	mv	s2,a0
  if(pid2 < 0){
    3b3e:	02054263          	bltz	a0,3b62 <iter+0x9e>
    printf("grind: fork failed\n");
    exit(1);
  }
  if(pid2 == 0){
    3b42:	ed0d                	bnez	a0,3b7c <iter+0xb8>
    rand_next ^= 7177;
    3b44:	00001697          	auipc	a3,0x1
    3b48:	4bc68693          	addi	a3,a3,1212 # 5000 <rand_next>
    3b4c:	629c                	ld	a5,0(a3)
    3b4e:	6709                	lui	a4,0x2
    3b50:	c0970713          	addi	a4,a4,-1015 # 1c09 <do_rand-0x13f7>
    3b54:	8fb9                	xor	a5,a5,a4
    3b56:	e29c                	sd	a5,0(a3)
    go(1);
    3b58:	4505                	li	a0,1
    3b5a:	fffff097          	auipc	ra,0xfffff
    3b5e:	51e080e7          	jalr	1310(ra) # 3078 <go>
    printf("grind: fork failed\n");
    3b62:	00001517          	auipc	a0,0x1
    3b66:	9de50513          	addi	a0,a0,-1570 # 4540 <malloc+0x1ee>
    3b6a:	00000097          	auipc	ra,0x0
    3b6e:	72a080e7          	jalr	1834(ra) # 4294 <printf>
    exit(1);
    3b72:	4505                	li	a0,1
    3b74:	00000097          	auipc	ra,0x0
    3b78:	378080e7          	jalr	888(ra) # 3eec <exit>
    exit(0);
  }

  int st1 = -1;
    3b7c:	57fd                	li	a5,-1
    3b7e:	fcf42e23          	sw	a5,-36(s0)
  wait(&st1);
    3b82:	fdc40513          	addi	a0,s0,-36
    3b86:	00000097          	auipc	ra,0x0
    3b8a:	36e080e7          	jalr	878(ra) # 3ef4 <wait>
  if(st1 != 0){
    3b8e:	fdc42783          	lw	a5,-36(s0)
    3b92:	ef99                	bnez	a5,3bb0 <iter+0xec>
    kill(pid1);
    kill(pid2);
  }
  int st2 = -1;
    3b94:	57fd                	li	a5,-1
    3b96:	fcf42c23          	sw	a5,-40(s0)
  wait(&st2);
    3b9a:	fd840513          	addi	a0,s0,-40
    3b9e:	00000097          	auipc	ra,0x0
    3ba2:	356080e7          	jalr	854(ra) # 3ef4 <wait>

  exit(0);
    3ba6:	4501                	li	a0,0
    3ba8:	00000097          	auipc	ra,0x0
    3bac:	344080e7          	jalr	836(ra) # 3eec <exit>
    kill(pid1);
    3bb0:	8526                	mv	a0,s1
    3bb2:	00000097          	auipc	ra,0x0
    3bb6:	372080e7          	jalr	882(ra) # 3f24 <kill>
    kill(pid2);
    3bba:	854a                	mv	a0,s2
    3bbc:	00000097          	auipc	ra,0x0
    3bc0:	368080e7          	jalr	872(ra) # 3f24 <kill>
    3bc4:	bfc1                	j	3b94 <iter+0xd0>

0000000000003bc6 <main>:
}

int
main()
{
    3bc6:	1101                	addi	sp,sp,-32
    3bc8:	ec06                	sd	ra,24(sp)
    3bca:	e822                	sd	s0,16(sp)
    3bcc:	e426                	sd	s1,8(sp)
    3bce:	1000                	addi	s0,sp,32
    }
    if(pid > 0){
      wait(0);
    }
    sleep(20);
    rand_next += 1;
    3bd0:	00001497          	auipc	s1,0x1
    3bd4:	43048493          	addi	s1,s1,1072 # 5000 <rand_next>
    3bd8:	a829                	j	3bf2 <main+0x2c>
      iter();
    3bda:	00000097          	auipc	ra,0x0
    3bde:	eea080e7          	jalr	-278(ra) # 3ac4 <iter>
    sleep(20);
    3be2:	4551                	li	a0,20
    3be4:	00000097          	auipc	ra,0x0
    3be8:	3a0080e7          	jalr	928(ra) # 3f84 <sleep>
    rand_next += 1;
    3bec:	609c                	ld	a5,0(s1)
    3bee:	0785                	addi	a5,a5,1
    3bf0:	e09c                	sd	a5,0(s1)
    int pid = fork();
    3bf2:	00000097          	auipc	ra,0x0
    3bf6:	2f2080e7          	jalr	754(ra) # 3ee4 <fork>
    if(pid == 0){
    3bfa:	d165                	beqz	a0,3bda <main+0x14>
    if(pid > 0){
    3bfc:	fea053e3          	blez	a0,3be2 <main+0x1c>
      wait(0);
    3c00:	4501                	li	a0,0
    3c02:	00000097          	auipc	ra,0x0
    3c06:	2f2080e7          	jalr	754(ra) # 3ef4 <wait>
    3c0a:	bfe1                	j	3be2 <main+0x1c>

0000000000003c0c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    3c0c:	1141                	addi	sp,sp,-16
    3c0e:	e406                	sd	ra,8(sp)
    3c10:	e022                	sd	s0,0(sp)
    3c12:	0800                	addi	s0,sp,16
  extern int main();
  main();
    3c14:	00000097          	auipc	ra,0x0
    3c18:	fb2080e7          	jalr	-78(ra) # 3bc6 <main>
  exit(0);
    3c1c:	4501                	li	a0,0
    3c1e:	00000097          	auipc	ra,0x0
    3c22:	2ce080e7          	jalr	718(ra) # 3eec <exit>

0000000000003c26 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    3c26:	1141                	addi	sp,sp,-16
    3c28:	e422                	sd	s0,8(sp)
    3c2a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3c2c:	87aa                	mv	a5,a0
    3c2e:	0585                	addi	a1,a1,1
    3c30:	0785                	addi	a5,a5,1
    3c32:	fff5c703          	lbu	a4,-1(a1)
    3c36:	fee78fa3          	sb	a4,-1(a5)
    3c3a:	fb75                	bnez	a4,3c2e <strcpy+0x8>
    ;
  return os;
}
    3c3c:	6422                	ld	s0,8(sp)
    3c3e:	0141                	addi	sp,sp,16
    3c40:	8082                	ret

0000000000003c42 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3c42:	1141                	addi	sp,sp,-16
    3c44:	e422                	sd	s0,8(sp)
    3c46:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    3c48:	00054783          	lbu	a5,0(a0)
    3c4c:	cb91                	beqz	a5,3c60 <strcmp+0x1e>
    3c4e:	0005c703          	lbu	a4,0(a1)
    3c52:	00f71763          	bne	a4,a5,3c60 <strcmp+0x1e>
    p++, q++;
    3c56:	0505                	addi	a0,a0,1
    3c58:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    3c5a:	00054783          	lbu	a5,0(a0)
    3c5e:	fbe5                	bnez	a5,3c4e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    3c60:	0005c503          	lbu	a0,0(a1)
}
    3c64:	40a7853b          	subw	a0,a5,a0
    3c68:	6422                	ld	s0,8(sp)
    3c6a:	0141                	addi	sp,sp,16
    3c6c:	8082                	ret

0000000000003c6e <strlen>:

uint
strlen(const char *s)
{
    3c6e:	1141                	addi	sp,sp,-16
    3c70:	e422                	sd	s0,8(sp)
    3c72:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    3c74:	00054783          	lbu	a5,0(a0)
    3c78:	cf91                	beqz	a5,3c94 <strlen+0x26>
    3c7a:	0505                	addi	a0,a0,1
    3c7c:	87aa                	mv	a5,a0
    3c7e:	4685                	li	a3,1
    3c80:	9e89                	subw	a3,a3,a0
    3c82:	00f6853b          	addw	a0,a3,a5
    3c86:	0785                	addi	a5,a5,1
    3c88:	fff7c703          	lbu	a4,-1(a5)
    3c8c:	fb7d                	bnez	a4,3c82 <strlen+0x14>
    ;
  return n;
}
    3c8e:	6422                	ld	s0,8(sp)
    3c90:	0141                	addi	sp,sp,16
    3c92:	8082                	ret
  for(n = 0; s[n]; n++)
    3c94:	4501                	li	a0,0
    3c96:	bfe5                	j	3c8e <strlen+0x20>

0000000000003c98 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3c98:	1141                	addi	sp,sp,-16
    3c9a:	e422                	sd	s0,8(sp)
    3c9c:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    3c9e:	ca19                	beqz	a2,3cb4 <memset+0x1c>
    3ca0:	87aa                	mv	a5,a0
    3ca2:	1602                	slli	a2,a2,0x20
    3ca4:	9201                	srli	a2,a2,0x20
    3ca6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    3caa:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    3cae:	0785                	addi	a5,a5,1
    3cb0:	fee79de3          	bne	a5,a4,3caa <memset+0x12>
  }
  return dst;
}
    3cb4:	6422                	ld	s0,8(sp)
    3cb6:	0141                	addi	sp,sp,16
    3cb8:	8082                	ret

0000000000003cba <strchr>:

char*
strchr(const char *s, char c)
{
    3cba:	1141                	addi	sp,sp,-16
    3cbc:	e422                	sd	s0,8(sp)
    3cbe:	0800                	addi	s0,sp,16
  for(; *s; s++)
    3cc0:	00054783          	lbu	a5,0(a0)
    3cc4:	cb99                	beqz	a5,3cda <strchr+0x20>
    if(*s == c)
    3cc6:	00f58763          	beq	a1,a5,3cd4 <strchr+0x1a>
  for(; *s; s++)
    3cca:	0505                	addi	a0,a0,1
    3ccc:	00054783          	lbu	a5,0(a0)
    3cd0:	fbfd                	bnez	a5,3cc6 <strchr+0xc>
      return (char*)s;
  return 0;
    3cd2:	4501                	li	a0,0
}
    3cd4:	6422                	ld	s0,8(sp)
    3cd6:	0141                	addi	sp,sp,16
    3cd8:	8082                	ret
  return 0;
    3cda:	4501                	li	a0,0
    3cdc:	bfe5                	j	3cd4 <strchr+0x1a>

0000000000003cde <gets>:

char*
gets(char *buf, int max)
{
    3cde:	711d                	addi	sp,sp,-96
    3ce0:	ec86                	sd	ra,88(sp)
    3ce2:	e8a2                	sd	s0,80(sp)
    3ce4:	e4a6                	sd	s1,72(sp)
    3ce6:	e0ca                	sd	s2,64(sp)
    3ce8:	fc4e                	sd	s3,56(sp)
    3cea:	f852                	sd	s4,48(sp)
    3cec:	f456                	sd	s5,40(sp)
    3cee:	f05a                	sd	s6,32(sp)
    3cf0:	ec5e                	sd	s7,24(sp)
    3cf2:	1080                	addi	s0,sp,96
    3cf4:	8baa                	mv	s7,a0
    3cf6:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3cf8:	892a                	mv	s2,a0
    3cfa:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    3cfc:	4aa9                	li	s5,10
    3cfe:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    3d00:	89a6                	mv	s3,s1
    3d02:	2485                	addiw	s1,s1,1
    3d04:	0344d863          	bge	s1,s4,3d34 <gets+0x56>
    cc = read(0, &c, 1);
    3d08:	4605                	li	a2,1
    3d0a:	faf40593          	addi	a1,s0,-81
    3d0e:	4501                	li	a0,0
    3d10:	00000097          	auipc	ra,0x0
    3d14:	1fc080e7          	jalr	508(ra) # 3f0c <read>
    if(cc < 1)
    3d18:	00a05e63          	blez	a0,3d34 <gets+0x56>
    buf[i++] = c;
    3d1c:	faf44783          	lbu	a5,-81(s0)
    3d20:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    3d24:	01578763          	beq	a5,s5,3d32 <gets+0x54>
    3d28:	0905                	addi	s2,s2,1
    3d2a:	fd679be3          	bne	a5,s6,3d00 <gets+0x22>
  for(i=0; i+1 < max; ){
    3d2e:	89a6                	mv	s3,s1
    3d30:	a011                	j	3d34 <gets+0x56>
    3d32:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    3d34:	99de                	add	s3,s3,s7
    3d36:	00098023          	sb	zero,0(s3)
  return buf;
}
    3d3a:	855e                	mv	a0,s7
    3d3c:	60e6                	ld	ra,88(sp)
    3d3e:	6446                	ld	s0,80(sp)
    3d40:	64a6                	ld	s1,72(sp)
    3d42:	6906                	ld	s2,64(sp)
    3d44:	79e2                	ld	s3,56(sp)
    3d46:	7a42                	ld	s4,48(sp)
    3d48:	7aa2                	ld	s5,40(sp)
    3d4a:	7b02                	ld	s6,32(sp)
    3d4c:	6be2                	ld	s7,24(sp)
    3d4e:	6125                	addi	sp,sp,96
    3d50:	8082                	ret

0000000000003d52 <stat>:

int
stat(const char *n, struct stat *st)
{
    3d52:	1101                	addi	sp,sp,-32
    3d54:	ec06                	sd	ra,24(sp)
    3d56:	e822                	sd	s0,16(sp)
    3d58:	e426                	sd	s1,8(sp)
    3d5a:	e04a                	sd	s2,0(sp)
    3d5c:	1000                	addi	s0,sp,32
    3d5e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3d60:	4581                	li	a1,0
    3d62:	00000097          	auipc	ra,0x0
    3d66:	1d2080e7          	jalr	466(ra) # 3f34 <open>
  if(fd < 0)
    3d6a:	02054563          	bltz	a0,3d94 <stat+0x42>
    3d6e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    3d70:	85ca                	mv	a1,s2
    3d72:	00000097          	auipc	ra,0x0
    3d76:	1da080e7          	jalr	474(ra) # 3f4c <fstat>
    3d7a:	892a                	mv	s2,a0
  close(fd);
    3d7c:	8526                	mv	a0,s1
    3d7e:	00000097          	auipc	ra,0x0
    3d82:	19e080e7          	jalr	414(ra) # 3f1c <close>
  return r;
}
    3d86:	854a                	mv	a0,s2
    3d88:	60e2                	ld	ra,24(sp)
    3d8a:	6442                	ld	s0,16(sp)
    3d8c:	64a2                	ld	s1,8(sp)
    3d8e:	6902                	ld	s2,0(sp)
    3d90:	6105                	addi	sp,sp,32
    3d92:	8082                	ret
    return -1;
    3d94:	597d                	li	s2,-1
    3d96:	bfc5                	j	3d86 <stat+0x34>

0000000000003d98 <atoi>:

int
atoi(const char *s)
{
    3d98:	1141                	addi	sp,sp,-16
    3d9a:	e422                	sd	s0,8(sp)
    3d9c:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3d9e:	00054603          	lbu	a2,0(a0)
    3da2:	fd06079b          	addiw	a5,a2,-48
    3da6:	0ff7f793          	andi	a5,a5,255
    3daa:	4725                	li	a4,9
    3dac:	02f76963          	bltu	a4,a5,3dde <atoi+0x46>
    3db0:	86aa                	mv	a3,a0
  n = 0;
    3db2:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    3db4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    3db6:	0685                	addi	a3,a3,1
    3db8:	0025179b          	slliw	a5,a0,0x2
    3dbc:	9fa9                	addw	a5,a5,a0
    3dbe:	0017979b          	slliw	a5,a5,0x1
    3dc2:	9fb1                	addw	a5,a5,a2
    3dc4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    3dc8:	0006c603          	lbu	a2,0(a3)
    3dcc:	fd06071b          	addiw	a4,a2,-48
    3dd0:	0ff77713          	andi	a4,a4,255
    3dd4:	fee5f1e3          	bgeu	a1,a4,3db6 <atoi+0x1e>
  return n;
}
    3dd8:	6422                	ld	s0,8(sp)
    3dda:	0141                	addi	sp,sp,16
    3ddc:	8082                	ret
  n = 0;
    3dde:	4501                	li	a0,0
    3de0:	bfe5                	j	3dd8 <atoi+0x40>

0000000000003de2 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3de2:	1141                	addi	sp,sp,-16
    3de4:	e422                	sd	s0,8(sp)
    3de6:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    3de8:	02b57463          	bgeu	a0,a1,3e10 <memmove+0x2e>
    while(n-- > 0)
    3dec:	00c05f63          	blez	a2,3e0a <memmove+0x28>
    3df0:	1602                	slli	a2,a2,0x20
    3df2:	9201                	srli	a2,a2,0x20
    3df4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    3df8:	872a                	mv	a4,a0
      *dst++ = *src++;
    3dfa:	0585                	addi	a1,a1,1
    3dfc:	0705                	addi	a4,a4,1
    3dfe:	fff5c683          	lbu	a3,-1(a1)
    3e02:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    3e06:	fee79ae3          	bne	a5,a4,3dfa <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    3e0a:	6422                	ld	s0,8(sp)
    3e0c:	0141                	addi	sp,sp,16
    3e0e:	8082                	ret
    dst += n;
    3e10:	00c50733          	add	a4,a0,a2
    src += n;
    3e14:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    3e16:	fec05ae3          	blez	a2,3e0a <memmove+0x28>
    3e1a:	fff6079b          	addiw	a5,a2,-1
    3e1e:	1782                	slli	a5,a5,0x20
    3e20:	9381                	srli	a5,a5,0x20
    3e22:	fff7c793          	not	a5,a5
    3e26:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    3e28:	15fd                	addi	a1,a1,-1
    3e2a:	177d                	addi	a4,a4,-1
    3e2c:	0005c683          	lbu	a3,0(a1)
    3e30:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    3e34:	fee79ae3          	bne	a5,a4,3e28 <memmove+0x46>
    3e38:	bfc9                	j	3e0a <memmove+0x28>

0000000000003e3a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    3e3a:	1141                	addi	sp,sp,-16
    3e3c:	e422                	sd	s0,8(sp)
    3e3e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    3e40:	ca05                	beqz	a2,3e70 <memcmp+0x36>
    3e42:	fff6069b          	addiw	a3,a2,-1
    3e46:	1682                	slli	a3,a3,0x20
    3e48:	9281                	srli	a3,a3,0x20
    3e4a:	0685                	addi	a3,a3,1
    3e4c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    3e4e:	00054783          	lbu	a5,0(a0)
    3e52:	0005c703          	lbu	a4,0(a1)
    3e56:	00e79863          	bne	a5,a4,3e66 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    3e5a:	0505                	addi	a0,a0,1
    p2++;
    3e5c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    3e5e:	fed518e3          	bne	a0,a3,3e4e <memcmp+0x14>
  }
  return 0;
    3e62:	4501                	li	a0,0
    3e64:	a019                	j	3e6a <memcmp+0x30>
      return *p1 - *p2;
    3e66:	40e7853b          	subw	a0,a5,a4
}
    3e6a:	6422                	ld	s0,8(sp)
    3e6c:	0141                	addi	sp,sp,16
    3e6e:	8082                	ret
  return 0;
    3e70:	4501                	li	a0,0
    3e72:	bfe5                	j	3e6a <memcmp+0x30>

0000000000003e74 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    3e74:	1141                	addi	sp,sp,-16
    3e76:	e406                	sd	ra,8(sp)
    3e78:	e022                	sd	s0,0(sp)
    3e7a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    3e7c:	00000097          	auipc	ra,0x0
    3e80:	f66080e7          	jalr	-154(ra) # 3de2 <memmove>
}
    3e84:	60a2                	ld	ra,8(sp)
    3e86:	6402                	ld	s0,0(sp)
    3e88:	0141                	addi	sp,sp,16
    3e8a:	8082                	ret

0000000000003e8c <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    3e8c:	1141                	addi	sp,sp,-16
    3e8e:	e422                	sd	s0,8(sp)
    3e90:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    3e92:	00052023          	sw	zero,0(a0)
}  
    3e96:	6422                	ld	s0,8(sp)
    3e98:	0141                	addi	sp,sp,16
    3e9a:	8082                	ret

0000000000003e9c <lock>:

void lock(struct spinlock * lk) 
{    
    3e9c:	1141                	addi	sp,sp,-16
    3e9e:	e422                	sd	s0,8(sp)
    3ea0:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    3ea2:	4705                	li	a4,1
    3ea4:	87ba                	mv	a5,a4
    3ea6:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    3eaa:	2781                	sext.w	a5,a5
    3eac:	ffe5                	bnez	a5,3ea4 <lock+0x8>
}  
    3eae:	6422                	ld	s0,8(sp)
    3eb0:	0141                	addi	sp,sp,16
    3eb2:	8082                	ret

0000000000003eb4 <unlock>:

void unlock(struct spinlock * lk) 
{   
    3eb4:	1141                	addi	sp,sp,-16
    3eb6:	e422                	sd	s0,8(sp)
    3eb8:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    3eba:	0f50000f          	fence	iorw,ow
    3ebe:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    3ec2:	6422                	ld	s0,8(sp)
    3ec4:	0141                	addi	sp,sp,16
    3ec6:	8082                	ret

0000000000003ec8 <isDigit>:

unsigned int isDigit(char *c) {
    3ec8:	1141                	addi	sp,sp,-16
    3eca:	e422                	sd	s0,8(sp)
    3ecc:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    3ece:	00054503          	lbu	a0,0(a0)
    3ed2:	fd05051b          	addiw	a0,a0,-48
    3ed6:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    3eda:	00a53513          	sltiu	a0,a0,10
    3ede:	6422                	ld	s0,8(sp)
    3ee0:	0141                	addi	sp,sp,16
    3ee2:	8082                	ret

0000000000003ee4 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    3ee4:	4885                	li	a7,1
 ecall
    3ee6:	00000073          	ecall
 ret
    3eea:	8082                	ret

0000000000003eec <exit>:
.global exit
exit:
 li a7, SYS_exit
    3eec:	4889                	li	a7,2
 ecall
    3eee:	00000073          	ecall
 ret
    3ef2:	8082                	ret

0000000000003ef4 <wait>:
.global wait
wait:
 li a7, SYS_wait
    3ef4:	488d                	li	a7,3
 ecall
    3ef6:	00000073          	ecall
 ret
    3efa:	8082                	ret

0000000000003efc <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    3efc:	48e1                	li	a7,24
 ecall
    3efe:	00000073          	ecall
 ret
    3f02:	8082                	ret

0000000000003f04 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    3f04:	4891                	li	a7,4
 ecall
    3f06:	00000073          	ecall
 ret
    3f0a:	8082                	ret

0000000000003f0c <read>:
.global read
read:
 li a7, SYS_read
    3f0c:	4895                	li	a7,5
 ecall
    3f0e:	00000073          	ecall
 ret
    3f12:	8082                	ret

0000000000003f14 <write>:
.global write
write:
 li a7, SYS_write
    3f14:	48c1                	li	a7,16
 ecall
    3f16:	00000073          	ecall
 ret
    3f1a:	8082                	ret

0000000000003f1c <close>:
.global close
close:
 li a7, SYS_close
    3f1c:	48d5                	li	a7,21
 ecall
    3f1e:	00000073          	ecall
 ret
    3f22:	8082                	ret

0000000000003f24 <kill>:
.global kill
kill:
 li a7, SYS_kill
    3f24:	4899                	li	a7,6
 ecall
    3f26:	00000073          	ecall
 ret
    3f2a:	8082                	ret

0000000000003f2c <exec>:
.global exec
exec:
 li a7, SYS_exec
    3f2c:	489d                	li	a7,7
 ecall
    3f2e:	00000073          	ecall
 ret
    3f32:	8082                	ret

0000000000003f34 <open>:
.global open
open:
 li a7, SYS_open
    3f34:	48bd                	li	a7,15
 ecall
    3f36:	00000073          	ecall
 ret
    3f3a:	8082                	ret

0000000000003f3c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    3f3c:	48c5                	li	a7,17
 ecall
    3f3e:	00000073          	ecall
 ret
    3f42:	8082                	ret

0000000000003f44 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    3f44:	48c9                	li	a7,18
 ecall
    3f46:	00000073          	ecall
 ret
    3f4a:	8082                	ret

0000000000003f4c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    3f4c:	48a1                	li	a7,8
 ecall
    3f4e:	00000073          	ecall
 ret
    3f52:	8082                	ret

0000000000003f54 <link>:
.global link
link:
 li a7, SYS_link
    3f54:	48cd                	li	a7,19
 ecall
    3f56:	00000073          	ecall
 ret
    3f5a:	8082                	ret

0000000000003f5c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    3f5c:	48d1                	li	a7,20
 ecall
    3f5e:	00000073          	ecall
 ret
    3f62:	8082                	ret

0000000000003f64 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    3f64:	48a5                	li	a7,9
 ecall
    3f66:	00000073          	ecall
 ret
    3f6a:	8082                	ret

0000000000003f6c <dup>:
.global dup
dup:
 li a7, SYS_dup
    3f6c:	48a9                	li	a7,10
 ecall
    3f6e:	00000073          	ecall
 ret
    3f72:	8082                	ret

0000000000003f74 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    3f74:	48ad                	li	a7,11
 ecall
    3f76:	00000073          	ecall
 ret
    3f7a:	8082                	ret

0000000000003f7c <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    3f7c:	48b1                	li	a7,12
 ecall
    3f7e:	00000073          	ecall
 ret
    3f82:	8082                	ret

0000000000003f84 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    3f84:	48b5                	li	a7,13
 ecall
    3f86:	00000073          	ecall
 ret
    3f8a:	8082                	ret

0000000000003f8c <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    3f8c:	48b9                	li	a7,14
 ecall
    3f8e:	00000073          	ecall
 ret
    3f92:	8082                	ret

0000000000003f94 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    3f94:	48d9                	li	a7,22
 ecall
    3f96:	00000073          	ecall
 ret
    3f9a:	8082                	ret

0000000000003f9c <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    3f9c:	48dd                	li	a7,23
 ecall
    3f9e:	00000073          	ecall
 ret
    3fa2:	8082                	ret

0000000000003fa4 <ps>:
.global ps
ps:
 li a7, SYS_ps
    3fa4:	48e5                	li	a7,25
 ecall
    3fa6:	00000073          	ecall
 ret
    3faa:	8082                	ret

0000000000003fac <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    3fac:	48e9                	li	a7,26
 ecall
    3fae:	00000073          	ecall
 ret
    3fb2:	8082                	ret

0000000000003fb4 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    3fb4:	48ed                	li	a7,27
 ecall
    3fb6:	00000073          	ecall
 ret
    3fba:	8082                	ret

0000000000003fbc <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    3fbc:	1101                	addi	sp,sp,-32
    3fbe:	ec06                	sd	ra,24(sp)
    3fc0:	e822                	sd	s0,16(sp)
    3fc2:	1000                	addi	s0,sp,32
    3fc4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    3fc8:	4605                	li	a2,1
    3fca:	fef40593          	addi	a1,s0,-17
    3fce:	00000097          	auipc	ra,0x0
    3fd2:	f46080e7          	jalr	-186(ra) # 3f14 <write>
}
    3fd6:	60e2                	ld	ra,24(sp)
    3fd8:	6442                	ld	s0,16(sp)
    3fda:	6105                	addi	sp,sp,32
    3fdc:	8082                	ret

0000000000003fde <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3fde:	7139                	addi	sp,sp,-64
    3fe0:	fc06                	sd	ra,56(sp)
    3fe2:	f822                	sd	s0,48(sp)
    3fe4:	f426                	sd	s1,40(sp)
    3fe6:	f04a                	sd	s2,32(sp)
    3fe8:	ec4e                	sd	s3,24(sp)
    3fea:	0080                	addi	s0,sp,64
    3fec:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3fee:	c299                	beqz	a3,3ff4 <printint+0x16>
    3ff0:	0805c863          	bltz	a1,4080 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3ff4:	2581                	sext.w	a1,a1
  neg = 0;
    3ff6:	4881                	li	a7,0
    3ff8:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    3ffc:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    3ffe:	2601                	sext.w	a2,a2
    4000:	00000517          	auipc	a0,0x0
    4004:	73050513          	addi	a0,a0,1840 # 4730 <digits>
    4008:	883a                	mv	a6,a4
    400a:	2705                	addiw	a4,a4,1
    400c:	02c5f7bb          	remuw	a5,a1,a2
    4010:	1782                	slli	a5,a5,0x20
    4012:	9381                	srli	a5,a5,0x20
    4014:	97aa                	add	a5,a5,a0
    4016:	0007c783          	lbu	a5,0(a5)
    401a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    401e:	0005879b          	sext.w	a5,a1
    4022:	02c5d5bb          	divuw	a1,a1,a2
    4026:	0685                	addi	a3,a3,1
    4028:	fec7f0e3          	bgeu	a5,a2,4008 <printint+0x2a>
  if(neg)
    402c:	00088b63          	beqz	a7,4042 <printint+0x64>
    buf[i++] = '-';
    4030:	fd040793          	addi	a5,s0,-48
    4034:	973e                	add	a4,a4,a5
    4036:	02d00793          	li	a5,45
    403a:	fef70823          	sb	a5,-16(a4)
    403e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    4042:	02e05863          	blez	a4,4072 <printint+0x94>
    4046:	fc040793          	addi	a5,s0,-64
    404a:	00e78933          	add	s2,a5,a4
    404e:	fff78993          	addi	s3,a5,-1
    4052:	99ba                	add	s3,s3,a4
    4054:	377d                	addiw	a4,a4,-1
    4056:	1702                	slli	a4,a4,0x20
    4058:	9301                	srli	a4,a4,0x20
    405a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    405e:	fff94583          	lbu	a1,-1(s2)
    4062:	8526                	mv	a0,s1
    4064:	00000097          	auipc	ra,0x0
    4068:	f58080e7          	jalr	-168(ra) # 3fbc <putc>
  while(--i >= 0)
    406c:	197d                	addi	s2,s2,-1
    406e:	ff3918e3          	bne	s2,s3,405e <printint+0x80>
}
    4072:	70e2                	ld	ra,56(sp)
    4074:	7442                	ld	s0,48(sp)
    4076:	74a2                	ld	s1,40(sp)
    4078:	7902                	ld	s2,32(sp)
    407a:	69e2                	ld	s3,24(sp)
    407c:	6121                	addi	sp,sp,64
    407e:	8082                	ret
    x = -xx;
    4080:	40b005bb          	negw	a1,a1
    neg = 1;
    4084:	4885                	li	a7,1
    x = -xx;
    4086:	bf8d                	j	3ff8 <printint+0x1a>

0000000000004088 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    4088:	7119                	addi	sp,sp,-128
    408a:	fc86                	sd	ra,120(sp)
    408c:	f8a2                	sd	s0,112(sp)
    408e:	f4a6                	sd	s1,104(sp)
    4090:	f0ca                	sd	s2,96(sp)
    4092:	ecce                	sd	s3,88(sp)
    4094:	e8d2                	sd	s4,80(sp)
    4096:	e4d6                	sd	s5,72(sp)
    4098:	e0da                	sd	s6,64(sp)
    409a:	fc5e                	sd	s7,56(sp)
    409c:	f862                	sd	s8,48(sp)
    409e:	f466                	sd	s9,40(sp)
    40a0:	f06a                	sd	s10,32(sp)
    40a2:	ec6e                	sd	s11,24(sp)
    40a4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    40a6:	0005c903          	lbu	s2,0(a1)
    40aa:	18090f63          	beqz	s2,4248 <vprintf+0x1c0>
    40ae:	8aaa                	mv	s5,a0
    40b0:	8b32                	mv	s6,a2
    40b2:	00158493          	addi	s1,a1,1
  state = 0;
    40b6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    40b8:	02500a13          	li	s4,37
      if(c == 'd'){
    40bc:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    40c0:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    40c4:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    40c8:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    40cc:	00000b97          	auipc	s7,0x0
    40d0:	664b8b93          	addi	s7,s7,1636 # 4730 <digits>
    40d4:	a839                	j	40f2 <vprintf+0x6a>
        putc(fd, c);
    40d6:	85ca                	mv	a1,s2
    40d8:	8556                	mv	a0,s5
    40da:	00000097          	auipc	ra,0x0
    40de:	ee2080e7          	jalr	-286(ra) # 3fbc <putc>
    40e2:	a019                	j	40e8 <vprintf+0x60>
    } else if(state == '%'){
    40e4:	01498f63          	beq	s3,s4,4102 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    40e8:	0485                	addi	s1,s1,1
    40ea:	fff4c903          	lbu	s2,-1(s1)
    40ee:	14090d63          	beqz	s2,4248 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    40f2:	0009079b          	sext.w	a5,s2
    if(state == 0){
    40f6:	fe0997e3          	bnez	s3,40e4 <vprintf+0x5c>
      if(c == '%'){
    40fa:	fd479ee3          	bne	a5,s4,40d6 <vprintf+0x4e>
        state = '%';
    40fe:	89be                	mv	s3,a5
    4100:	b7e5                	j	40e8 <vprintf+0x60>
      if(c == 'd'){
    4102:	05878063          	beq	a5,s8,4142 <vprintf+0xba>
      } else if(c == 'l') {
    4106:	05978c63          	beq	a5,s9,415e <vprintf+0xd6>
      } else if(c == 'x') {
    410a:	07a78863          	beq	a5,s10,417a <vprintf+0xf2>
      } else if(c == 'p') {
    410e:	09b78463          	beq	a5,s11,4196 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    4112:	07300713          	li	a4,115
    4116:	0ce78663          	beq	a5,a4,41e2 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    411a:	06300713          	li	a4,99
    411e:	0ee78e63          	beq	a5,a4,421a <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    4122:	11478863          	beq	a5,s4,4232 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    4126:	85d2                	mv	a1,s4
    4128:	8556                	mv	a0,s5
    412a:	00000097          	auipc	ra,0x0
    412e:	e92080e7          	jalr	-366(ra) # 3fbc <putc>
        putc(fd, c);
    4132:	85ca                	mv	a1,s2
    4134:	8556                	mv	a0,s5
    4136:	00000097          	auipc	ra,0x0
    413a:	e86080e7          	jalr	-378(ra) # 3fbc <putc>
      }
      state = 0;
    413e:	4981                	li	s3,0
    4140:	b765                	j	40e8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    4142:	008b0913          	addi	s2,s6,8
    4146:	4685                	li	a3,1
    4148:	4629                	li	a2,10
    414a:	000b2583          	lw	a1,0(s6)
    414e:	8556                	mv	a0,s5
    4150:	00000097          	auipc	ra,0x0
    4154:	e8e080e7          	jalr	-370(ra) # 3fde <printint>
    4158:	8b4a                	mv	s6,s2
      state = 0;
    415a:	4981                	li	s3,0
    415c:	b771                	j	40e8 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    415e:	008b0913          	addi	s2,s6,8
    4162:	4681                	li	a3,0
    4164:	4629                	li	a2,10
    4166:	000b2583          	lw	a1,0(s6)
    416a:	8556                	mv	a0,s5
    416c:	00000097          	auipc	ra,0x0
    4170:	e72080e7          	jalr	-398(ra) # 3fde <printint>
    4174:	8b4a                	mv	s6,s2
      state = 0;
    4176:	4981                	li	s3,0
    4178:	bf85                	j	40e8 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    417a:	008b0913          	addi	s2,s6,8
    417e:	4681                	li	a3,0
    4180:	4641                	li	a2,16
    4182:	000b2583          	lw	a1,0(s6)
    4186:	8556                	mv	a0,s5
    4188:	00000097          	auipc	ra,0x0
    418c:	e56080e7          	jalr	-426(ra) # 3fde <printint>
    4190:	8b4a                	mv	s6,s2
      state = 0;
    4192:	4981                	li	s3,0
    4194:	bf91                	j	40e8 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    4196:	008b0793          	addi	a5,s6,8
    419a:	f8f43423          	sd	a5,-120(s0)
    419e:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    41a2:	03000593          	li	a1,48
    41a6:	8556                	mv	a0,s5
    41a8:	00000097          	auipc	ra,0x0
    41ac:	e14080e7          	jalr	-492(ra) # 3fbc <putc>
  putc(fd, 'x');
    41b0:	85ea                	mv	a1,s10
    41b2:	8556                	mv	a0,s5
    41b4:	00000097          	auipc	ra,0x0
    41b8:	e08080e7          	jalr	-504(ra) # 3fbc <putc>
    41bc:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    41be:	03c9d793          	srli	a5,s3,0x3c
    41c2:	97de                	add	a5,a5,s7
    41c4:	0007c583          	lbu	a1,0(a5)
    41c8:	8556                	mv	a0,s5
    41ca:	00000097          	auipc	ra,0x0
    41ce:	df2080e7          	jalr	-526(ra) # 3fbc <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    41d2:	0992                	slli	s3,s3,0x4
    41d4:	397d                	addiw	s2,s2,-1
    41d6:	fe0914e3          	bnez	s2,41be <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    41da:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    41de:	4981                	li	s3,0
    41e0:	b721                	j	40e8 <vprintf+0x60>
        s = va_arg(ap, char*);
    41e2:	008b0993          	addi	s3,s6,8
    41e6:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    41ea:	02090163          	beqz	s2,420c <vprintf+0x184>
        while(*s != 0){
    41ee:	00094583          	lbu	a1,0(s2)
    41f2:	c9a1                	beqz	a1,4242 <vprintf+0x1ba>
          putc(fd, *s);
    41f4:	8556                	mv	a0,s5
    41f6:	00000097          	auipc	ra,0x0
    41fa:	dc6080e7          	jalr	-570(ra) # 3fbc <putc>
          s++;
    41fe:	0905                	addi	s2,s2,1
        while(*s != 0){
    4200:	00094583          	lbu	a1,0(s2)
    4204:	f9e5                	bnez	a1,41f4 <vprintf+0x16c>
        s = va_arg(ap, char*);
    4206:	8b4e                	mv	s6,s3
      state = 0;
    4208:	4981                	li	s3,0
    420a:	bdf9                	j	40e8 <vprintf+0x60>
          s = "(null)";
    420c:	00000917          	auipc	s2,0x0
    4210:	51c90913          	addi	s2,s2,1308 # 4728 <malloc+0x3d6>
        while(*s != 0){
    4214:	02800593          	li	a1,40
    4218:	bff1                	j	41f4 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    421a:	008b0913          	addi	s2,s6,8
    421e:	000b4583          	lbu	a1,0(s6)
    4222:	8556                	mv	a0,s5
    4224:	00000097          	auipc	ra,0x0
    4228:	d98080e7          	jalr	-616(ra) # 3fbc <putc>
    422c:	8b4a                	mv	s6,s2
      state = 0;
    422e:	4981                	li	s3,0
    4230:	bd65                	j	40e8 <vprintf+0x60>
        putc(fd, c);
    4232:	85d2                	mv	a1,s4
    4234:	8556                	mv	a0,s5
    4236:	00000097          	auipc	ra,0x0
    423a:	d86080e7          	jalr	-634(ra) # 3fbc <putc>
      state = 0;
    423e:	4981                	li	s3,0
    4240:	b565                	j	40e8 <vprintf+0x60>
        s = va_arg(ap, char*);
    4242:	8b4e                	mv	s6,s3
      state = 0;
    4244:	4981                	li	s3,0
    4246:	b54d                	j	40e8 <vprintf+0x60>
    }
  }
}
    4248:	70e6                	ld	ra,120(sp)
    424a:	7446                	ld	s0,112(sp)
    424c:	74a6                	ld	s1,104(sp)
    424e:	7906                	ld	s2,96(sp)
    4250:	69e6                	ld	s3,88(sp)
    4252:	6a46                	ld	s4,80(sp)
    4254:	6aa6                	ld	s5,72(sp)
    4256:	6b06                	ld	s6,64(sp)
    4258:	7be2                	ld	s7,56(sp)
    425a:	7c42                	ld	s8,48(sp)
    425c:	7ca2                	ld	s9,40(sp)
    425e:	7d02                	ld	s10,32(sp)
    4260:	6de2                	ld	s11,24(sp)
    4262:	6109                	addi	sp,sp,128
    4264:	8082                	ret

0000000000004266 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    4266:	715d                	addi	sp,sp,-80
    4268:	ec06                	sd	ra,24(sp)
    426a:	e822                	sd	s0,16(sp)
    426c:	1000                	addi	s0,sp,32
    426e:	e010                	sd	a2,0(s0)
    4270:	e414                	sd	a3,8(s0)
    4272:	e818                	sd	a4,16(s0)
    4274:	ec1c                	sd	a5,24(s0)
    4276:	03043023          	sd	a6,32(s0)
    427a:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    427e:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    4282:	8622                	mv	a2,s0
    4284:	00000097          	auipc	ra,0x0
    4288:	e04080e7          	jalr	-508(ra) # 4088 <vprintf>
}
    428c:	60e2                	ld	ra,24(sp)
    428e:	6442                	ld	s0,16(sp)
    4290:	6161                	addi	sp,sp,80
    4292:	8082                	ret

0000000000004294 <printf>:

void
printf(const char *fmt, ...)
{
    4294:	711d                	addi	sp,sp,-96
    4296:	ec06                	sd	ra,24(sp)
    4298:	e822                	sd	s0,16(sp)
    429a:	1000                	addi	s0,sp,32
    429c:	e40c                	sd	a1,8(s0)
    429e:	e810                	sd	a2,16(s0)
    42a0:	ec14                	sd	a3,24(s0)
    42a2:	f018                	sd	a4,32(s0)
    42a4:	f41c                	sd	a5,40(s0)
    42a6:	03043823          	sd	a6,48(s0)
    42aa:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    42ae:	00840613          	addi	a2,s0,8
    42b2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    42b6:	85aa                	mv	a1,a0
    42b8:	4505                	li	a0,1
    42ba:	00000097          	auipc	ra,0x0
    42be:	dce080e7          	jalr	-562(ra) # 4088 <vprintf>
}
    42c2:	60e2                	ld	ra,24(sp)
    42c4:	6442                	ld	s0,16(sp)
    42c6:	6125                	addi	sp,sp,96
    42c8:	8082                	ret

00000000000042ca <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    42ca:	1141                	addi	sp,sp,-16
    42cc:	e422                	sd	s0,8(sp)
    42ce:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    42d0:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    42d4:	00001797          	auipc	a5,0x1
    42d8:	d3c7b783          	ld	a5,-708(a5) # 5010 <freep>
    42dc:	a805                	j	430c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    42de:	4618                	lw	a4,8(a2)
    42e0:	9db9                	addw	a1,a1,a4
    42e2:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    42e6:	6398                	ld	a4,0(a5)
    42e8:	6318                	ld	a4,0(a4)
    42ea:	fee53823          	sd	a4,-16(a0)
    42ee:	a091                	j	4332 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    42f0:	ff852703          	lw	a4,-8(a0)
    42f4:	9e39                	addw	a2,a2,a4
    42f6:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    42f8:	ff053703          	ld	a4,-16(a0)
    42fc:	e398                	sd	a4,0(a5)
    42fe:	a099                	j	4344 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4300:	6398                	ld	a4,0(a5)
    4302:	00e7e463          	bltu	a5,a4,430a <free+0x40>
    4306:	00e6ea63          	bltu	a3,a4,431a <free+0x50>
{
    430a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    430c:	fed7fae3          	bgeu	a5,a3,4300 <free+0x36>
    4310:	6398                	ld	a4,0(a5)
    4312:	00e6e463          	bltu	a3,a4,431a <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4316:	fee7eae3          	bltu	a5,a4,430a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    431a:	ff852583          	lw	a1,-8(a0)
    431e:	6390                	ld	a2,0(a5)
    4320:	02059713          	slli	a4,a1,0x20
    4324:	9301                	srli	a4,a4,0x20
    4326:	0712                	slli	a4,a4,0x4
    4328:	9736                	add	a4,a4,a3
    432a:	fae60ae3          	beq	a2,a4,42de <free+0x14>
    bp->s.ptr = p->s.ptr;
    432e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    4332:	4790                	lw	a2,8(a5)
    4334:	02061713          	slli	a4,a2,0x20
    4338:	9301                	srli	a4,a4,0x20
    433a:	0712                	slli	a4,a4,0x4
    433c:	973e                	add	a4,a4,a5
    433e:	fae689e3          	beq	a3,a4,42f0 <free+0x26>
  } else
    p->s.ptr = bp;
    4342:	e394                	sd	a3,0(a5)
  freep = p;
    4344:	00001717          	auipc	a4,0x1
    4348:	ccf73623          	sd	a5,-820(a4) # 5010 <freep>
}
    434c:	6422                	ld	s0,8(sp)
    434e:	0141                	addi	sp,sp,16
    4350:	8082                	ret

0000000000004352 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    4352:	7139                	addi	sp,sp,-64
    4354:	fc06                	sd	ra,56(sp)
    4356:	f822                	sd	s0,48(sp)
    4358:	f426                	sd	s1,40(sp)
    435a:	f04a                	sd	s2,32(sp)
    435c:	ec4e                	sd	s3,24(sp)
    435e:	e852                	sd	s4,16(sp)
    4360:	e456                	sd	s5,8(sp)
    4362:	e05a                	sd	s6,0(sp)
    4364:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4366:	02051493          	slli	s1,a0,0x20
    436a:	9081                	srli	s1,s1,0x20
    436c:	04bd                	addi	s1,s1,15
    436e:	8091                	srli	s1,s1,0x4
    4370:	0014899b          	addiw	s3,s1,1
    4374:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    4376:	00001517          	auipc	a0,0x1
    437a:	c9a53503          	ld	a0,-870(a0) # 5010 <freep>
    437e:	c515                	beqz	a0,43aa <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4380:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    4382:	4798                	lw	a4,8(a5)
    4384:	02977f63          	bgeu	a4,s1,43c2 <malloc+0x70>
    4388:	8a4e                	mv	s4,s3
    438a:	0009871b          	sext.w	a4,s3
    438e:	6685                	lui	a3,0x1
    4390:	00d77363          	bgeu	a4,a3,4396 <malloc+0x44>
    4394:	6a05                	lui	s4,0x1
    4396:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    439a:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    439e:	00001917          	auipc	s2,0x1
    43a2:	c7290913          	addi	s2,s2,-910 # 5010 <freep>
  if(p == (char*)-1)
    43a6:	5afd                	li	s5,-1
    43a8:	a88d                	j	441a <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    43aa:	00001797          	auipc	a5,0x1
    43ae:	05e78793          	addi	a5,a5,94 # 5408 <base>
    43b2:	00001717          	auipc	a4,0x1
    43b6:	c4f73f23          	sd	a5,-930(a4) # 5010 <freep>
    43ba:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    43bc:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    43c0:	b7e1                	j	4388 <malloc+0x36>
      if(p->s.size == nunits)
    43c2:	02e48b63          	beq	s1,a4,43f8 <malloc+0xa6>
        p->s.size -= nunits;
    43c6:	4137073b          	subw	a4,a4,s3
    43ca:	c798                	sw	a4,8(a5)
        p += p->s.size;
    43cc:	1702                	slli	a4,a4,0x20
    43ce:	9301                	srli	a4,a4,0x20
    43d0:	0712                	slli	a4,a4,0x4
    43d2:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    43d4:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    43d8:	00001717          	auipc	a4,0x1
    43dc:	c2a73c23          	sd	a0,-968(a4) # 5010 <freep>
      return (void*)(p + 1);
    43e0:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    43e4:	70e2                	ld	ra,56(sp)
    43e6:	7442                	ld	s0,48(sp)
    43e8:	74a2                	ld	s1,40(sp)
    43ea:	7902                	ld	s2,32(sp)
    43ec:	69e2                	ld	s3,24(sp)
    43ee:	6a42                	ld	s4,16(sp)
    43f0:	6aa2                	ld	s5,8(sp)
    43f2:	6b02                	ld	s6,0(sp)
    43f4:	6121                	addi	sp,sp,64
    43f6:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    43f8:	6398                	ld	a4,0(a5)
    43fa:	e118                	sd	a4,0(a0)
    43fc:	bff1                	j	43d8 <malloc+0x86>
  hp->s.size = nu;
    43fe:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    4402:	0541                	addi	a0,a0,16
    4404:	00000097          	auipc	ra,0x0
    4408:	ec6080e7          	jalr	-314(ra) # 42ca <free>
  return freep;
    440c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    4410:	d971                	beqz	a0,43e4 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4412:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    4414:	4798                	lw	a4,8(a5)
    4416:	fa9776e3          	bgeu	a4,s1,43c2 <malloc+0x70>
    if(p == freep)
    441a:	00093703          	ld	a4,0(s2)
    441e:	853e                	mv	a0,a5
    4420:	fef719e3          	bne	a4,a5,4412 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    4424:	8552                	mv	a0,s4
    4426:	00000097          	auipc	ra,0x0
    442a:	b56080e7          	jalr	-1194(ra) # 3f7c <sbrk>
  if(p == (char*)-1)
    442e:	fd5518e3          	bne	a0,s5,43fe <malloc+0xac>
        return 0;
    4432:	4501                	li	a0,0
    4434:	bf45                	j	43e4 <malloc+0x92>
