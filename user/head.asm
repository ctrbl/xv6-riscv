
user/_head:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <head>:
#include "user/user.h"

#define BUF_SIZE      512
#define DEFAULT_LINES  14

void head(int fd, const int count) {
    3000:	dc010113          	addi	sp,sp,-576
    3004:	22113c23          	sd	ra,568(sp)
    3008:	22813823          	sd	s0,560(sp)
    300c:	22913423          	sd	s1,552(sp)
    3010:	23213023          	sd	s2,544(sp)
    3014:	21313c23          	sd	s3,536(sp)
    3018:	21413823          	sd	s4,528(sp)
    301c:	21513423          	sd	s5,520(sp)
    3020:	21613023          	sd	s6,512(sp)
    3024:	0480                	addi	s0,sp,576
    3026:	8b2a                	mv	s6,a0
    3028:	8a2e                	mv	s4,a1
  int n, i, line = 1;
    302a:	4905                	li	s2,1
        break;  
      if (write(1, &buf[i], 1) != 1) {
        printf("head: write error\n");
        exit(1);
      }
      if (buf[i] == '\n')
    302c:	4aa9                	li	s5,10
  if (line > count) 
    302e:	04b04b63          	bgtz	a1,3084 <head+0x84>
    exit(0); 
    3032:	4501                	li	a0,0
    3034:	00000097          	auipc	ra,0x0
    3038:	576080e7          	jalr	1398(ra) # 35aa <exit>
        printf("head: write error\n");
    303c:	00001517          	auipc	a0,0x1
    3040:	ac450513          	addi	a0,a0,-1340 # 3b00 <malloc+0xf0>
    3044:	00001097          	auipc	ra,0x1
    3048:	90e080e7          	jalr	-1778(ra) # 3952 <printf>
        exit(1);
    304c:	4505                	li	a0,1
    304e:	00000097          	auipc	ra,0x0
    3052:	55c080e7          	jalr	1372(ra) # 35aa <exit>
    for (i = 0; i < n; i++) {
    3056:	03348563          	beq	s1,s3,3080 <head+0x80>
      if (line > count)
    305a:	0485                	addi	s1,s1,1
    305c:	052a4c63          	blt	s4,s2,30b4 <head+0xb4>
      if (write(1, &buf[i], 1) != 1) {
    3060:	4605                	li	a2,1
    3062:	85a6                	mv	a1,s1
    3064:	4505                	li	a0,1
    3066:	00000097          	auipc	ra,0x0
    306a:	56c080e7          	jalr	1388(ra) # 35d2 <write>
    306e:	4785                	li	a5,1
    3070:	fcf516e3          	bne	a0,a5,303c <head+0x3c>
      if (buf[i] == '\n')
    3074:	0004c783          	lbu	a5,0(s1)
    3078:	fd579fe3          	bne	a5,s5,3056 <head+0x56>
        line++;
    307c:	2905                	addiw	s2,s2,1
    307e:	bfe1                	j	3056 <head+0x56>
    }
    if (line > count)
    3080:	032a4a63          	blt	s4,s2,30b4 <head+0xb4>
  while ((n = read(fd, buf, BUF_SIZE)) > 0) {
    3084:	20000613          	li	a2,512
    3088:	dc040593          	addi	a1,s0,-576
    308c:	855a                	mv	a0,s6
    308e:	00000097          	auipc	ra,0x0
    3092:	53c080e7          	jalr	1340(ra) # 35ca <read>
    3096:	00a05d63          	blez	a0,30b0 <head+0xb0>
      if (line > count)
    309a:	012a4d63          	blt	s4,s2,30b4 <head+0xb4>
    309e:	dc040493          	addi	s1,s0,-576
    30a2:	fff5099b          	addiw	s3,a0,-1
    30a6:	1982                	slli	s3,s3,0x20
    30a8:	0209d993          	srli	s3,s3,0x20
    30ac:	99a6                	add	s3,s3,s1
    30ae:	bf4d                	j	3060 <head+0x60>
      break;
  }
  if (n < 0) {
    30b0:	02054563          	bltz	a0,30da <head+0xda>
    printf("head: read error\n");
    exit(1);
  }
}
    30b4:	23813083          	ld	ra,568(sp)
    30b8:	23013403          	ld	s0,560(sp)
    30bc:	22813483          	ld	s1,552(sp)
    30c0:	22013903          	ld	s2,544(sp)
    30c4:	21813983          	ld	s3,536(sp)
    30c8:	21013a03          	ld	s4,528(sp)
    30cc:	20813a83          	ld	s5,520(sp)
    30d0:	20013b03          	ld	s6,512(sp)
    30d4:	24010113          	addi	sp,sp,576
    30d8:	8082                	ret
    printf("head: read error\n");
    30da:	00001517          	auipc	a0,0x1
    30de:	a3e50513          	addi	a0,a0,-1474 # 3b18 <malloc+0x108>
    30e2:	00001097          	auipc	ra,0x1
    30e6:	870080e7          	jalr	-1936(ra) # 3952 <printf>
    exit(1);
    30ea:	4505                	li	a0,1
    30ec:	00000097          	auipc	ra,0x0
    30f0:	4be080e7          	jalr	1214(ra) # 35aa <exit>

00000000000030f4 <main>:

int main(int argc, char *argv[]) {
    30f4:	715d                	addi	sp,sp,-80
    30f6:	e486                	sd	ra,72(sp)
    30f8:	e0a2                	sd	s0,64(sp)
    30fa:	fc26                	sd	s1,56(sp)
    30fc:	f84a                	sd	s2,48(sp)
    30fe:	f44e                	sd	s3,40(sp)
    3100:	f052                	sd	s4,32(sp)
    3102:	ec56                	sd	s5,24(sp)
    3104:	e85a                	sd	s6,16(sp)
    3106:	e45e                	sd	s7,8(sp)
    3108:	e062                	sd	s8,0(sp)
    310a:	0880                	addi	s0,sp,80
    310c:	8a2a                	mv	s4,a0
    310e:	84ae                	mv	s1,a1
  int fd, i = 1, j, count = DEFAULT_LINES;  

  printf("Head command is getting executed in user mode.\n"); 
    3110:	00001517          	auipc	a0,0x1
    3114:	a2050513          	addi	a0,a0,-1504 # 3b30 <malloc+0x120>
    3118:	00001097          	auipc	ra,0x1
    311c:	83a080e7          	jalr	-1990(ra) # 3952 <printf>

  // check for default head vs numbered head
  if (!strcmp(argv[1], "-n")) {
    3120:	00001597          	auipc	a1,0x1
    3124:	a4058593          	addi	a1,a1,-1472 # 3b60 <malloc+0x150>
    3128:	6488                	ld	a0,8(s1)
    312a:	00000097          	auipc	ra,0x0
    312e:	1d6080e7          	jalr	470(ra) # 3300 <strcmp>
    3132:	e929                	bnez	a0,3184 <main+0x90>
    for (j = 0; argv[2][j] != '\0'; j++) {
    3134:	6888                	ld	a0,16(s1)
    3136:	00054783          	lbu	a5,0(a0)
    313a:	c385                	beqz	a5,315a <main+0x66>
    313c:	4905                	li	s2,1
      if (!isDigit(&argv[2][j])) {
    313e:	00000097          	auipc	ra,0x0
    3142:	448080e7          	jalr	1096(ra) # 3586 <isDigit>
    3146:	2501                	sext.w	a0,a0
    3148:	c105                	beqz	a0,3168 <main+0x74>
    for (j = 0; argv[2][j] != '\0'; j++) {
    314a:	689c                	ld	a5,16(s1)
    314c:	01278533          	add	a0,a5,s2
    3150:	0905                	addi	s2,s2,1
    3152:	00054703          	lbu	a4,0(a0)
    3156:	f765                	bnez	a4,313e <main+0x4a>
    3158:	853e                	mv	a0,a5
        printf("head: invalid number of lines: '%s'\n", argv[2]); 
	      exit(1); 
      }
    }
    count = atoi(argv[2]); 
    315a:	00000097          	auipc	ra,0x0
    315e:	2fc080e7          	jalr	764(ra) # 3456 <atoi>
    3162:	8aaa                	mv	s5,a0
    i = 3;    
    3164:	450d                	li	a0,3
    3166:	a805                	j	3196 <main+0xa2>
        printf("head: invalid number of lines: '%s'\n", argv[2]); 
    3168:	688c                	ld	a1,16(s1)
    316a:	00001517          	auipc	a0,0x1
    316e:	9fe50513          	addi	a0,a0,-1538 # 3b68 <malloc+0x158>
    3172:	00000097          	auipc	ra,0x0
    3176:	7e0080e7          	jalr	2016(ra) # 3952 <printf>
	      exit(1); 
    317a:	4505                	li	a0,1
    317c:	00000097          	auipc	ra,0x0
    3180:	42e080e7          	jalr	1070(ra) # 35aa <exit>
  }
  else if (argv[1][0] == '-') {
    3184:	6488                	ld	a0,8(s1)
    3186:	00054703          	lbu	a4,0(a0)
    318a:	02d00793          	li	a5,45
    318e:	02f70c63          	beq	a4,a5,31c6 <main+0xd2>
  int fd, i = 1, j, count = DEFAULT_LINES;  
    3192:	4ab9                	li	s5,14
    3194:	4505                	li	a0,1
    if (strlen(num)) 
      count = atoi(num); 
    i = 2;   
  } 
 
  if (i >= argc) 
    3196:	0b455e63          	bge	a0,s4,3252 <main+0x15e>
    head(0, count);
  else {
    for (j = i; j < argc; j++) {
    319a:	00351913          	slli	s2,a0,0x3
    319e:	9926                	add	s2,s2,s1
    31a0:	fffa099b          	addiw	s3,s4,-1
    31a4:	40a989bb          	subw	s3,s3,a0
    31a8:	1982                	slli	s3,s3,0x20
    31aa:	0209d993          	srli	s3,s3,0x20
    31ae:	99aa                	add	s3,s3,a0
    31b0:	098e                	slli	s3,s3,0x3
    31b2:	04a1                	addi	s1,s1,8
    31b4:	99a6                	add	s3,s3,s1
      if ((fd = open(argv[j], 0)) < 0) { 
        printf("head: cannot open '%s' for reading: No such file or directory\n", argv[j]);
        exit(1); 	
      } 
      if (argc - i >= 2) 
    31b6:	40aa0a3b          	subw	s4,s4,a0
    31ba:	4b85                	li	s7,1
        printf("\n==> %s <==\n", argv[j]); 
    31bc:	00001c17          	auipc	s8,0x1
    31c0:	a34c0c13          	addi	s8,s8,-1484 # 3bf0 <malloc+0x1e0>
    31c4:	a8f9                	j	32a2 <main+0x1ae>
    char *num = malloc(strlen(argv[1])); 
    31c6:	00000097          	auipc	ra,0x0
    31ca:	166080e7          	jalr	358(ra) # 332c <strlen>
    31ce:	2501                	sext.w	a0,a0
    31d0:	00001097          	auipc	ra,0x1
    31d4:	840080e7          	jalr	-1984(ra) # 3a10 <malloc>
    31d8:	89aa                	mv	s3,a0
    for (j = 1; argv[1][j] != '\0'; j++) {
    31da:	649c                	ld	a5,8(s1)
    31dc:	00178513          	addi	a0,a5,1
    31e0:	0017c783          	lbu	a5,1(a5)
    31e4:	c795                	beqz	a5,3210 <main+0x11c>
    31e6:	4905                	li	s2,1
      if (!isDigit(&argv[1][j])) {
    31e8:	00000097          	auipc	ra,0x0
    31ec:	39e080e7          	jalr	926(ra) # 3586 <isDigit>
    31f0:	2501                	sext.w	a0,a0
    31f2:	c915                	beqz	a0,3226 <main+0x132>
      num[j-1] = argv[1][j];       
    31f4:	649c                	ld	a5,8(s1)
    31f6:	97ca                	add	a5,a5,s2
    31f8:	0007c703          	lbu	a4,0(a5)
    31fc:	012987b3          	add	a5,s3,s2
    3200:	fee78fa3          	sb	a4,-1(a5)
    for (j = 1; argv[1][j] != '\0'; j++) {
    3204:	0905                	addi	s2,s2,1
    3206:	6488                	ld	a0,8(s1)
    3208:	954a                	add	a0,a0,s2
    320a:	00054783          	lbu	a5,0(a0)
    320e:	ffe9                	bnez	a5,31e8 <main+0xf4>
    if (strlen(num)) 
    3210:	854e                	mv	a0,s3
    3212:	00000097          	auipc	ra,0x0
    3216:	11a080e7          	jalr	282(ra) # 332c <strlen>
    321a:	0005079b          	sext.w	a5,a0
    321e:	e395                	bnez	a5,3242 <main+0x14e>
  int fd, i = 1, j, count = DEFAULT_LINES;  
    3220:	4ab9                	li	s5,14
    i = 2;   
    3222:	4509                	li	a0,2
    3224:	bf8d                	j	3196 <main+0xa2>
        printf("head: invalid option %s\n", argv[1]);
    3226:	648c                	ld	a1,8(s1)
    3228:	00001517          	auipc	a0,0x1
    322c:	96850513          	addi	a0,a0,-1688 # 3b90 <malloc+0x180>
    3230:	00000097          	auipc	ra,0x0
    3234:	722080e7          	jalr	1826(ra) # 3952 <printf>
	    exit(1);
    3238:	4505                	li	a0,1
    323a:	00000097          	auipc	ra,0x0
    323e:	370080e7          	jalr	880(ra) # 35aa <exit>
      count = atoi(num); 
    3242:	854e                	mv	a0,s3
    3244:	00000097          	auipc	ra,0x0
    3248:	212080e7          	jalr	530(ra) # 3456 <atoi>
    324c:	8aaa                	mv	s5,a0
    i = 2;   
    324e:	4509                	li	a0,2
    3250:	b799                	j	3196 <main+0xa2>
    head(0, count);
    3252:	85d6                	mv	a1,s5
    3254:	4501                	li	a0,0
    3256:	00000097          	auipc	ra,0x0
    325a:	daa080e7          	jalr	-598(ra) # 3000 <head>
      head(fd, count);        
      close(fd); 
    }
  } 
  exit(0); 
    325e:	4501                	li	a0,0
    3260:	00000097          	auipc	ra,0x0
    3264:	34a080e7          	jalr	842(ra) # 35aa <exit>
        printf("head: cannot open '%s' for reading: No such file or directory\n", argv[j]);
    3268:	00093583          	ld	a1,0(s2)
    326c:	00001517          	auipc	a0,0x1
    3270:	94450513          	addi	a0,a0,-1724 # 3bb0 <malloc+0x1a0>
    3274:	00000097          	auipc	ra,0x0
    3278:	6de080e7          	jalr	1758(ra) # 3952 <printf>
        exit(1); 	
    327c:	4505                	li	a0,1
    327e:	00000097          	auipc	ra,0x0
    3282:	32c080e7          	jalr	812(ra) # 35aa <exit>
      head(fd, count);        
    3286:	85d6                	mv	a1,s5
    3288:	8526                	mv	a0,s1
    328a:	00000097          	auipc	ra,0x0
    328e:	d76080e7          	jalr	-650(ra) # 3000 <head>
      close(fd); 
    3292:	8526                	mv	a0,s1
    3294:	00000097          	auipc	ra,0x0
    3298:	346080e7          	jalr	838(ra) # 35da <close>
    for (j = i; j < argc; j++) {
    329c:	0921                	addi	s2,s2,8
    329e:	fd3900e3          	beq	s2,s3,325e <main+0x16a>
      if ((fd = open(argv[j], 0)) < 0) { 
    32a2:	4581                	li	a1,0
    32a4:	00093503          	ld	a0,0(s2)
    32a8:	00000097          	auipc	ra,0x0
    32ac:	34a080e7          	jalr	842(ra) # 35f2 <open>
    32b0:	84aa                	mv	s1,a0
    32b2:	fa054be3          	bltz	a0,3268 <main+0x174>
      if (argc - i >= 2) 
    32b6:	fd4bd8e3          	bge	s7,s4,3286 <main+0x192>
        printf("\n==> %s <==\n", argv[j]); 
    32ba:	00093583          	ld	a1,0(s2)
    32be:	8562                	mv	a0,s8
    32c0:	00000097          	auipc	ra,0x0
    32c4:	692080e7          	jalr	1682(ra) # 3952 <printf>
    32c8:	bf7d                	j	3286 <main+0x192>

00000000000032ca <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    32ca:	1141                	addi	sp,sp,-16
    32cc:	e406                	sd	ra,8(sp)
    32ce:	e022                	sd	s0,0(sp)
    32d0:	0800                	addi	s0,sp,16
  extern int main();
  main();
    32d2:	00000097          	auipc	ra,0x0
    32d6:	e22080e7          	jalr	-478(ra) # 30f4 <main>
  exit(0);
    32da:	4501                	li	a0,0
    32dc:	00000097          	auipc	ra,0x0
    32e0:	2ce080e7          	jalr	718(ra) # 35aa <exit>

00000000000032e4 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    32e4:	1141                	addi	sp,sp,-16
    32e6:	e422                	sd	s0,8(sp)
    32e8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    32ea:	87aa                	mv	a5,a0
    32ec:	0585                	addi	a1,a1,1
    32ee:	0785                	addi	a5,a5,1
    32f0:	fff5c703          	lbu	a4,-1(a1)
    32f4:	fee78fa3          	sb	a4,-1(a5)
    32f8:	fb75                	bnez	a4,32ec <strcpy+0x8>
    ;
  return os;
}
    32fa:	6422                	ld	s0,8(sp)
    32fc:	0141                	addi	sp,sp,16
    32fe:	8082                	ret

0000000000003300 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3300:	1141                	addi	sp,sp,-16
    3302:	e422                	sd	s0,8(sp)
    3304:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    3306:	00054783          	lbu	a5,0(a0)
    330a:	cb91                	beqz	a5,331e <strcmp+0x1e>
    330c:	0005c703          	lbu	a4,0(a1)
    3310:	00f71763          	bne	a4,a5,331e <strcmp+0x1e>
    p++, q++;
    3314:	0505                	addi	a0,a0,1
    3316:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    3318:	00054783          	lbu	a5,0(a0)
    331c:	fbe5                	bnez	a5,330c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    331e:	0005c503          	lbu	a0,0(a1)
}
    3322:	40a7853b          	subw	a0,a5,a0
    3326:	6422                	ld	s0,8(sp)
    3328:	0141                	addi	sp,sp,16
    332a:	8082                	ret

000000000000332c <strlen>:

uint
strlen(const char *s)
{
    332c:	1141                	addi	sp,sp,-16
    332e:	e422                	sd	s0,8(sp)
    3330:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    3332:	00054783          	lbu	a5,0(a0)
    3336:	cf91                	beqz	a5,3352 <strlen+0x26>
    3338:	0505                	addi	a0,a0,1
    333a:	87aa                	mv	a5,a0
    333c:	4685                	li	a3,1
    333e:	9e89                	subw	a3,a3,a0
    3340:	00f6853b          	addw	a0,a3,a5
    3344:	0785                	addi	a5,a5,1
    3346:	fff7c703          	lbu	a4,-1(a5)
    334a:	fb7d                	bnez	a4,3340 <strlen+0x14>
    ;
  return n;
}
    334c:	6422                	ld	s0,8(sp)
    334e:	0141                	addi	sp,sp,16
    3350:	8082                	ret
  for(n = 0; s[n]; n++)
    3352:	4501                	li	a0,0
    3354:	bfe5                	j	334c <strlen+0x20>

0000000000003356 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3356:	1141                	addi	sp,sp,-16
    3358:	e422                	sd	s0,8(sp)
    335a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    335c:	ca19                	beqz	a2,3372 <memset+0x1c>
    335e:	87aa                	mv	a5,a0
    3360:	1602                	slli	a2,a2,0x20
    3362:	9201                	srli	a2,a2,0x20
    3364:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    3368:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    336c:	0785                	addi	a5,a5,1
    336e:	fee79de3          	bne	a5,a4,3368 <memset+0x12>
  }
  return dst;
}
    3372:	6422                	ld	s0,8(sp)
    3374:	0141                	addi	sp,sp,16
    3376:	8082                	ret

0000000000003378 <strchr>:

char*
strchr(const char *s, char c)
{
    3378:	1141                	addi	sp,sp,-16
    337a:	e422                	sd	s0,8(sp)
    337c:	0800                	addi	s0,sp,16
  for(; *s; s++)
    337e:	00054783          	lbu	a5,0(a0)
    3382:	cb99                	beqz	a5,3398 <strchr+0x20>
    if(*s == c)
    3384:	00f58763          	beq	a1,a5,3392 <strchr+0x1a>
  for(; *s; s++)
    3388:	0505                	addi	a0,a0,1
    338a:	00054783          	lbu	a5,0(a0)
    338e:	fbfd                	bnez	a5,3384 <strchr+0xc>
      return (char*)s;
  return 0;
    3390:	4501                	li	a0,0
}
    3392:	6422                	ld	s0,8(sp)
    3394:	0141                	addi	sp,sp,16
    3396:	8082                	ret
  return 0;
    3398:	4501                	li	a0,0
    339a:	bfe5                	j	3392 <strchr+0x1a>

000000000000339c <gets>:

char*
gets(char *buf, int max)
{
    339c:	711d                	addi	sp,sp,-96
    339e:	ec86                	sd	ra,88(sp)
    33a0:	e8a2                	sd	s0,80(sp)
    33a2:	e4a6                	sd	s1,72(sp)
    33a4:	e0ca                	sd	s2,64(sp)
    33a6:	fc4e                	sd	s3,56(sp)
    33a8:	f852                	sd	s4,48(sp)
    33aa:	f456                	sd	s5,40(sp)
    33ac:	f05a                	sd	s6,32(sp)
    33ae:	ec5e                	sd	s7,24(sp)
    33b0:	1080                	addi	s0,sp,96
    33b2:	8baa                	mv	s7,a0
    33b4:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    33b6:	892a                	mv	s2,a0
    33b8:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    33ba:	4aa9                	li	s5,10
    33bc:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    33be:	89a6                	mv	s3,s1
    33c0:	2485                	addiw	s1,s1,1
    33c2:	0344d863          	bge	s1,s4,33f2 <gets+0x56>
    cc = read(0, &c, 1);
    33c6:	4605                	li	a2,1
    33c8:	faf40593          	addi	a1,s0,-81
    33cc:	4501                	li	a0,0
    33ce:	00000097          	auipc	ra,0x0
    33d2:	1fc080e7          	jalr	508(ra) # 35ca <read>
    if(cc < 1)
    33d6:	00a05e63          	blez	a0,33f2 <gets+0x56>
    buf[i++] = c;
    33da:	faf44783          	lbu	a5,-81(s0)
    33de:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    33e2:	01578763          	beq	a5,s5,33f0 <gets+0x54>
    33e6:	0905                	addi	s2,s2,1
    33e8:	fd679be3          	bne	a5,s6,33be <gets+0x22>
  for(i=0; i+1 < max; ){
    33ec:	89a6                	mv	s3,s1
    33ee:	a011                	j	33f2 <gets+0x56>
    33f0:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    33f2:	99de                	add	s3,s3,s7
    33f4:	00098023          	sb	zero,0(s3)
  return buf;
}
    33f8:	855e                	mv	a0,s7
    33fa:	60e6                	ld	ra,88(sp)
    33fc:	6446                	ld	s0,80(sp)
    33fe:	64a6                	ld	s1,72(sp)
    3400:	6906                	ld	s2,64(sp)
    3402:	79e2                	ld	s3,56(sp)
    3404:	7a42                	ld	s4,48(sp)
    3406:	7aa2                	ld	s5,40(sp)
    3408:	7b02                	ld	s6,32(sp)
    340a:	6be2                	ld	s7,24(sp)
    340c:	6125                	addi	sp,sp,96
    340e:	8082                	ret

0000000000003410 <stat>:

int
stat(const char *n, struct stat *st)
{
    3410:	1101                	addi	sp,sp,-32
    3412:	ec06                	sd	ra,24(sp)
    3414:	e822                	sd	s0,16(sp)
    3416:	e426                	sd	s1,8(sp)
    3418:	e04a                	sd	s2,0(sp)
    341a:	1000                	addi	s0,sp,32
    341c:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    341e:	4581                	li	a1,0
    3420:	00000097          	auipc	ra,0x0
    3424:	1d2080e7          	jalr	466(ra) # 35f2 <open>
  if(fd < 0)
    3428:	02054563          	bltz	a0,3452 <stat+0x42>
    342c:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    342e:	85ca                	mv	a1,s2
    3430:	00000097          	auipc	ra,0x0
    3434:	1da080e7          	jalr	474(ra) # 360a <fstat>
    3438:	892a                	mv	s2,a0
  close(fd);
    343a:	8526                	mv	a0,s1
    343c:	00000097          	auipc	ra,0x0
    3440:	19e080e7          	jalr	414(ra) # 35da <close>
  return r;
}
    3444:	854a                	mv	a0,s2
    3446:	60e2                	ld	ra,24(sp)
    3448:	6442                	ld	s0,16(sp)
    344a:	64a2                	ld	s1,8(sp)
    344c:	6902                	ld	s2,0(sp)
    344e:	6105                	addi	sp,sp,32
    3450:	8082                	ret
    return -1;
    3452:	597d                	li	s2,-1
    3454:	bfc5                	j	3444 <stat+0x34>

0000000000003456 <atoi>:

int
atoi(const char *s)
{
    3456:	1141                	addi	sp,sp,-16
    3458:	e422                	sd	s0,8(sp)
    345a:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    345c:	00054603          	lbu	a2,0(a0)
    3460:	fd06079b          	addiw	a5,a2,-48
    3464:	0ff7f793          	andi	a5,a5,255
    3468:	4725                	li	a4,9
    346a:	02f76963          	bltu	a4,a5,349c <atoi+0x46>
    346e:	86aa                	mv	a3,a0
  n = 0;
    3470:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    3472:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    3474:	0685                	addi	a3,a3,1
    3476:	0025179b          	slliw	a5,a0,0x2
    347a:	9fa9                	addw	a5,a5,a0
    347c:	0017979b          	slliw	a5,a5,0x1
    3480:	9fb1                	addw	a5,a5,a2
    3482:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    3486:	0006c603          	lbu	a2,0(a3)
    348a:	fd06071b          	addiw	a4,a2,-48
    348e:	0ff77713          	andi	a4,a4,255
    3492:	fee5f1e3          	bgeu	a1,a4,3474 <atoi+0x1e>
  return n;
}
    3496:	6422                	ld	s0,8(sp)
    3498:	0141                	addi	sp,sp,16
    349a:	8082                	ret
  n = 0;
    349c:	4501                	li	a0,0
    349e:	bfe5                	j	3496 <atoi+0x40>

00000000000034a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    34a0:	1141                	addi	sp,sp,-16
    34a2:	e422                	sd	s0,8(sp)
    34a4:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    34a6:	02b57463          	bgeu	a0,a1,34ce <memmove+0x2e>
    while(n-- > 0)
    34aa:	00c05f63          	blez	a2,34c8 <memmove+0x28>
    34ae:	1602                	slli	a2,a2,0x20
    34b0:	9201                	srli	a2,a2,0x20
    34b2:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    34b6:	872a                	mv	a4,a0
      *dst++ = *src++;
    34b8:	0585                	addi	a1,a1,1
    34ba:	0705                	addi	a4,a4,1
    34bc:	fff5c683          	lbu	a3,-1(a1)
    34c0:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    34c4:	fee79ae3          	bne	a5,a4,34b8 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    34c8:	6422                	ld	s0,8(sp)
    34ca:	0141                	addi	sp,sp,16
    34cc:	8082                	ret
    dst += n;
    34ce:	00c50733          	add	a4,a0,a2
    src += n;
    34d2:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    34d4:	fec05ae3          	blez	a2,34c8 <memmove+0x28>
    34d8:	fff6079b          	addiw	a5,a2,-1
    34dc:	1782                	slli	a5,a5,0x20
    34de:	9381                	srli	a5,a5,0x20
    34e0:	fff7c793          	not	a5,a5
    34e4:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    34e6:	15fd                	addi	a1,a1,-1
    34e8:	177d                	addi	a4,a4,-1
    34ea:	0005c683          	lbu	a3,0(a1)
    34ee:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    34f2:	fee79ae3          	bne	a5,a4,34e6 <memmove+0x46>
    34f6:	bfc9                	j	34c8 <memmove+0x28>

00000000000034f8 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    34f8:	1141                	addi	sp,sp,-16
    34fa:	e422                	sd	s0,8(sp)
    34fc:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    34fe:	ca05                	beqz	a2,352e <memcmp+0x36>
    3500:	fff6069b          	addiw	a3,a2,-1
    3504:	1682                	slli	a3,a3,0x20
    3506:	9281                	srli	a3,a3,0x20
    3508:	0685                	addi	a3,a3,1
    350a:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    350c:	00054783          	lbu	a5,0(a0)
    3510:	0005c703          	lbu	a4,0(a1)
    3514:	00e79863          	bne	a5,a4,3524 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    3518:	0505                	addi	a0,a0,1
    p2++;
    351a:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    351c:	fed518e3          	bne	a0,a3,350c <memcmp+0x14>
  }
  return 0;
    3520:	4501                	li	a0,0
    3522:	a019                	j	3528 <memcmp+0x30>
      return *p1 - *p2;
    3524:	40e7853b          	subw	a0,a5,a4
}
    3528:	6422                	ld	s0,8(sp)
    352a:	0141                	addi	sp,sp,16
    352c:	8082                	ret
  return 0;
    352e:	4501                	li	a0,0
    3530:	bfe5                	j	3528 <memcmp+0x30>

0000000000003532 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    3532:	1141                	addi	sp,sp,-16
    3534:	e406                	sd	ra,8(sp)
    3536:	e022                	sd	s0,0(sp)
    3538:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    353a:	00000097          	auipc	ra,0x0
    353e:	f66080e7          	jalr	-154(ra) # 34a0 <memmove>
}
    3542:	60a2                	ld	ra,8(sp)
    3544:	6402                	ld	s0,0(sp)
    3546:	0141                	addi	sp,sp,16
    3548:	8082                	ret

000000000000354a <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    354a:	1141                	addi	sp,sp,-16
    354c:	e422                	sd	s0,8(sp)
    354e:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    3550:	00052023          	sw	zero,0(a0)
}  
    3554:	6422                	ld	s0,8(sp)
    3556:	0141                	addi	sp,sp,16
    3558:	8082                	ret

000000000000355a <lock>:

void lock(struct spinlock * lk) 
{    
    355a:	1141                	addi	sp,sp,-16
    355c:	e422                	sd	s0,8(sp)
    355e:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    3560:	4705                	li	a4,1
    3562:	87ba                	mv	a5,a4
    3564:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    3568:	2781                	sext.w	a5,a5
    356a:	ffe5                	bnez	a5,3562 <lock+0x8>
}  
    356c:	6422                	ld	s0,8(sp)
    356e:	0141                	addi	sp,sp,16
    3570:	8082                	ret

0000000000003572 <unlock>:

void unlock(struct spinlock * lk) 
{   
    3572:	1141                	addi	sp,sp,-16
    3574:	e422                	sd	s0,8(sp)
    3576:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    3578:	0f50000f          	fence	iorw,ow
    357c:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    3580:	6422                	ld	s0,8(sp)
    3582:	0141                	addi	sp,sp,16
    3584:	8082                	ret

0000000000003586 <isDigit>:

unsigned int isDigit(char *c) {
    3586:	1141                	addi	sp,sp,-16
    3588:	e422                	sd	s0,8(sp)
    358a:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    358c:	00054503          	lbu	a0,0(a0)
    3590:	fd05051b          	addiw	a0,a0,-48
    3594:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    3598:	00a53513          	sltiu	a0,a0,10
    359c:	6422                	ld	s0,8(sp)
    359e:	0141                	addi	sp,sp,16
    35a0:	8082                	ret

00000000000035a2 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    35a2:	4885                	li	a7,1
 ecall
    35a4:	00000073          	ecall
 ret
    35a8:	8082                	ret

00000000000035aa <exit>:
.global exit
exit:
 li a7, SYS_exit
    35aa:	4889                	li	a7,2
 ecall
    35ac:	00000073          	ecall
 ret
    35b0:	8082                	ret

00000000000035b2 <wait>:
.global wait
wait:
 li a7, SYS_wait
    35b2:	488d                	li	a7,3
 ecall
    35b4:	00000073          	ecall
 ret
    35b8:	8082                	ret

00000000000035ba <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    35ba:	48e1                	li	a7,24
 ecall
    35bc:	00000073          	ecall
 ret
    35c0:	8082                	ret

00000000000035c2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    35c2:	4891                	li	a7,4
 ecall
    35c4:	00000073          	ecall
 ret
    35c8:	8082                	ret

00000000000035ca <read>:
.global read
read:
 li a7, SYS_read
    35ca:	4895                	li	a7,5
 ecall
    35cc:	00000073          	ecall
 ret
    35d0:	8082                	ret

00000000000035d2 <write>:
.global write
write:
 li a7, SYS_write
    35d2:	48c1                	li	a7,16
 ecall
    35d4:	00000073          	ecall
 ret
    35d8:	8082                	ret

00000000000035da <close>:
.global close
close:
 li a7, SYS_close
    35da:	48d5                	li	a7,21
 ecall
    35dc:	00000073          	ecall
 ret
    35e0:	8082                	ret

00000000000035e2 <kill>:
.global kill
kill:
 li a7, SYS_kill
    35e2:	4899                	li	a7,6
 ecall
    35e4:	00000073          	ecall
 ret
    35e8:	8082                	ret

00000000000035ea <exec>:
.global exec
exec:
 li a7, SYS_exec
    35ea:	489d                	li	a7,7
 ecall
    35ec:	00000073          	ecall
 ret
    35f0:	8082                	ret

00000000000035f2 <open>:
.global open
open:
 li a7, SYS_open
    35f2:	48bd                	li	a7,15
 ecall
    35f4:	00000073          	ecall
 ret
    35f8:	8082                	ret

00000000000035fa <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    35fa:	48c5                	li	a7,17
 ecall
    35fc:	00000073          	ecall
 ret
    3600:	8082                	ret

0000000000003602 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    3602:	48c9                	li	a7,18
 ecall
    3604:	00000073          	ecall
 ret
    3608:	8082                	ret

000000000000360a <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    360a:	48a1                	li	a7,8
 ecall
    360c:	00000073          	ecall
 ret
    3610:	8082                	ret

0000000000003612 <link>:
.global link
link:
 li a7, SYS_link
    3612:	48cd                	li	a7,19
 ecall
    3614:	00000073          	ecall
 ret
    3618:	8082                	ret

000000000000361a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    361a:	48d1                	li	a7,20
 ecall
    361c:	00000073          	ecall
 ret
    3620:	8082                	ret

0000000000003622 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    3622:	48a5                	li	a7,9
 ecall
    3624:	00000073          	ecall
 ret
    3628:	8082                	ret

000000000000362a <dup>:
.global dup
dup:
 li a7, SYS_dup
    362a:	48a9                	li	a7,10
 ecall
    362c:	00000073          	ecall
 ret
    3630:	8082                	ret

0000000000003632 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    3632:	48ad                	li	a7,11
 ecall
    3634:	00000073          	ecall
 ret
    3638:	8082                	ret

000000000000363a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    363a:	48b1                	li	a7,12
 ecall
    363c:	00000073          	ecall
 ret
    3640:	8082                	ret

0000000000003642 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    3642:	48b5                	li	a7,13
 ecall
    3644:	00000073          	ecall
 ret
    3648:	8082                	ret

000000000000364a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    364a:	48b9                	li	a7,14
 ecall
    364c:	00000073          	ecall
 ret
    3650:	8082                	ret

0000000000003652 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    3652:	48d9                	li	a7,22
 ecall
    3654:	00000073          	ecall
 ret
    3658:	8082                	ret

000000000000365a <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    365a:	48dd                	li	a7,23
 ecall
    365c:	00000073          	ecall
 ret
    3660:	8082                	ret

0000000000003662 <ps>:
.global ps
ps:
 li a7, SYS_ps
    3662:	48e5                	li	a7,25
 ecall
    3664:	00000073          	ecall
 ret
    3668:	8082                	ret

000000000000366a <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    366a:	48e9                	li	a7,26
 ecall
    366c:	00000073          	ecall
 ret
    3670:	8082                	ret

0000000000003672 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    3672:	48ed                	li	a7,27
 ecall
    3674:	00000073          	ecall
 ret
    3678:	8082                	ret

000000000000367a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    367a:	1101                	addi	sp,sp,-32
    367c:	ec06                	sd	ra,24(sp)
    367e:	e822                	sd	s0,16(sp)
    3680:	1000                	addi	s0,sp,32
    3682:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    3686:	4605                	li	a2,1
    3688:	fef40593          	addi	a1,s0,-17
    368c:	00000097          	auipc	ra,0x0
    3690:	f46080e7          	jalr	-186(ra) # 35d2 <write>
}
    3694:	60e2                	ld	ra,24(sp)
    3696:	6442                	ld	s0,16(sp)
    3698:	6105                	addi	sp,sp,32
    369a:	8082                	ret

000000000000369c <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    369c:	7139                	addi	sp,sp,-64
    369e:	fc06                	sd	ra,56(sp)
    36a0:	f822                	sd	s0,48(sp)
    36a2:	f426                	sd	s1,40(sp)
    36a4:	f04a                	sd	s2,32(sp)
    36a6:	ec4e                	sd	s3,24(sp)
    36a8:	0080                	addi	s0,sp,64
    36aa:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    36ac:	c299                	beqz	a3,36b2 <printint+0x16>
    36ae:	0805c863          	bltz	a1,373e <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    36b2:	2581                	sext.w	a1,a1
  neg = 0;
    36b4:	4881                	li	a7,0
    36b6:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    36ba:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    36bc:	2601                	sext.w	a2,a2
    36be:	00000517          	auipc	a0,0x0
    36c2:	54a50513          	addi	a0,a0,1354 # 3c08 <digits>
    36c6:	883a                	mv	a6,a4
    36c8:	2705                	addiw	a4,a4,1
    36ca:	02c5f7bb          	remuw	a5,a1,a2
    36ce:	1782                	slli	a5,a5,0x20
    36d0:	9381                	srli	a5,a5,0x20
    36d2:	97aa                	add	a5,a5,a0
    36d4:	0007c783          	lbu	a5,0(a5)
    36d8:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    36dc:	0005879b          	sext.w	a5,a1
    36e0:	02c5d5bb          	divuw	a1,a1,a2
    36e4:	0685                	addi	a3,a3,1
    36e6:	fec7f0e3          	bgeu	a5,a2,36c6 <printint+0x2a>
  if(neg)
    36ea:	00088b63          	beqz	a7,3700 <printint+0x64>
    buf[i++] = '-';
    36ee:	fd040793          	addi	a5,s0,-48
    36f2:	973e                	add	a4,a4,a5
    36f4:	02d00793          	li	a5,45
    36f8:	fef70823          	sb	a5,-16(a4)
    36fc:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    3700:	02e05863          	blez	a4,3730 <printint+0x94>
    3704:	fc040793          	addi	a5,s0,-64
    3708:	00e78933          	add	s2,a5,a4
    370c:	fff78993          	addi	s3,a5,-1
    3710:	99ba                	add	s3,s3,a4
    3712:	377d                	addiw	a4,a4,-1
    3714:	1702                	slli	a4,a4,0x20
    3716:	9301                	srli	a4,a4,0x20
    3718:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    371c:	fff94583          	lbu	a1,-1(s2)
    3720:	8526                	mv	a0,s1
    3722:	00000097          	auipc	ra,0x0
    3726:	f58080e7          	jalr	-168(ra) # 367a <putc>
  while(--i >= 0)
    372a:	197d                	addi	s2,s2,-1
    372c:	ff3918e3          	bne	s2,s3,371c <printint+0x80>
}
    3730:	70e2                	ld	ra,56(sp)
    3732:	7442                	ld	s0,48(sp)
    3734:	74a2                	ld	s1,40(sp)
    3736:	7902                	ld	s2,32(sp)
    3738:	69e2                	ld	s3,24(sp)
    373a:	6121                	addi	sp,sp,64
    373c:	8082                	ret
    x = -xx;
    373e:	40b005bb          	negw	a1,a1
    neg = 1;
    3742:	4885                	li	a7,1
    x = -xx;
    3744:	bf8d                	j	36b6 <printint+0x1a>

0000000000003746 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    3746:	7119                	addi	sp,sp,-128
    3748:	fc86                	sd	ra,120(sp)
    374a:	f8a2                	sd	s0,112(sp)
    374c:	f4a6                	sd	s1,104(sp)
    374e:	f0ca                	sd	s2,96(sp)
    3750:	ecce                	sd	s3,88(sp)
    3752:	e8d2                	sd	s4,80(sp)
    3754:	e4d6                	sd	s5,72(sp)
    3756:	e0da                	sd	s6,64(sp)
    3758:	fc5e                	sd	s7,56(sp)
    375a:	f862                	sd	s8,48(sp)
    375c:	f466                	sd	s9,40(sp)
    375e:	f06a                	sd	s10,32(sp)
    3760:	ec6e                	sd	s11,24(sp)
    3762:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    3764:	0005c903          	lbu	s2,0(a1)
    3768:	18090f63          	beqz	s2,3906 <vprintf+0x1c0>
    376c:	8aaa                	mv	s5,a0
    376e:	8b32                	mv	s6,a2
    3770:	00158493          	addi	s1,a1,1
  state = 0;
    3774:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3776:	02500a13          	li	s4,37
      if(c == 'd'){
    377a:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    377e:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    3782:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    3786:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    378a:	00000b97          	auipc	s7,0x0
    378e:	47eb8b93          	addi	s7,s7,1150 # 3c08 <digits>
    3792:	a839                	j	37b0 <vprintf+0x6a>
        putc(fd, c);
    3794:	85ca                	mv	a1,s2
    3796:	8556                	mv	a0,s5
    3798:	00000097          	auipc	ra,0x0
    379c:	ee2080e7          	jalr	-286(ra) # 367a <putc>
    37a0:	a019                	j	37a6 <vprintf+0x60>
    } else if(state == '%'){
    37a2:	01498f63          	beq	s3,s4,37c0 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    37a6:	0485                	addi	s1,s1,1
    37a8:	fff4c903          	lbu	s2,-1(s1)
    37ac:	14090d63          	beqz	s2,3906 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    37b0:	0009079b          	sext.w	a5,s2
    if(state == 0){
    37b4:	fe0997e3          	bnez	s3,37a2 <vprintf+0x5c>
      if(c == '%'){
    37b8:	fd479ee3          	bne	a5,s4,3794 <vprintf+0x4e>
        state = '%';
    37bc:	89be                	mv	s3,a5
    37be:	b7e5                	j	37a6 <vprintf+0x60>
      if(c == 'd'){
    37c0:	05878063          	beq	a5,s8,3800 <vprintf+0xba>
      } else if(c == 'l') {
    37c4:	05978c63          	beq	a5,s9,381c <vprintf+0xd6>
      } else if(c == 'x') {
    37c8:	07a78863          	beq	a5,s10,3838 <vprintf+0xf2>
      } else if(c == 'p') {
    37cc:	09b78463          	beq	a5,s11,3854 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    37d0:	07300713          	li	a4,115
    37d4:	0ce78663          	beq	a5,a4,38a0 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    37d8:	06300713          	li	a4,99
    37dc:	0ee78e63          	beq	a5,a4,38d8 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    37e0:	11478863          	beq	a5,s4,38f0 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    37e4:	85d2                	mv	a1,s4
    37e6:	8556                	mv	a0,s5
    37e8:	00000097          	auipc	ra,0x0
    37ec:	e92080e7          	jalr	-366(ra) # 367a <putc>
        putc(fd, c);
    37f0:	85ca                	mv	a1,s2
    37f2:	8556                	mv	a0,s5
    37f4:	00000097          	auipc	ra,0x0
    37f8:	e86080e7          	jalr	-378(ra) # 367a <putc>
      }
      state = 0;
    37fc:	4981                	li	s3,0
    37fe:	b765                	j	37a6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    3800:	008b0913          	addi	s2,s6,8
    3804:	4685                	li	a3,1
    3806:	4629                	li	a2,10
    3808:	000b2583          	lw	a1,0(s6)
    380c:	8556                	mv	a0,s5
    380e:	00000097          	auipc	ra,0x0
    3812:	e8e080e7          	jalr	-370(ra) # 369c <printint>
    3816:	8b4a                	mv	s6,s2
      state = 0;
    3818:	4981                	li	s3,0
    381a:	b771                	j	37a6 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    381c:	008b0913          	addi	s2,s6,8
    3820:	4681                	li	a3,0
    3822:	4629                	li	a2,10
    3824:	000b2583          	lw	a1,0(s6)
    3828:	8556                	mv	a0,s5
    382a:	00000097          	auipc	ra,0x0
    382e:	e72080e7          	jalr	-398(ra) # 369c <printint>
    3832:	8b4a                	mv	s6,s2
      state = 0;
    3834:	4981                	li	s3,0
    3836:	bf85                	j	37a6 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    3838:	008b0913          	addi	s2,s6,8
    383c:	4681                	li	a3,0
    383e:	4641                	li	a2,16
    3840:	000b2583          	lw	a1,0(s6)
    3844:	8556                	mv	a0,s5
    3846:	00000097          	auipc	ra,0x0
    384a:	e56080e7          	jalr	-426(ra) # 369c <printint>
    384e:	8b4a                	mv	s6,s2
      state = 0;
    3850:	4981                	li	s3,0
    3852:	bf91                	j	37a6 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    3854:	008b0793          	addi	a5,s6,8
    3858:	f8f43423          	sd	a5,-120(s0)
    385c:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    3860:	03000593          	li	a1,48
    3864:	8556                	mv	a0,s5
    3866:	00000097          	auipc	ra,0x0
    386a:	e14080e7          	jalr	-492(ra) # 367a <putc>
  putc(fd, 'x');
    386e:	85ea                	mv	a1,s10
    3870:	8556                	mv	a0,s5
    3872:	00000097          	auipc	ra,0x0
    3876:	e08080e7          	jalr	-504(ra) # 367a <putc>
    387a:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    387c:	03c9d793          	srli	a5,s3,0x3c
    3880:	97de                	add	a5,a5,s7
    3882:	0007c583          	lbu	a1,0(a5)
    3886:	8556                	mv	a0,s5
    3888:	00000097          	auipc	ra,0x0
    388c:	df2080e7          	jalr	-526(ra) # 367a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    3890:	0992                	slli	s3,s3,0x4
    3892:	397d                	addiw	s2,s2,-1
    3894:	fe0914e3          	bnez	s2,387c <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    3898:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    389c:	4981                	li	s3,0
    389e:	b721                	j	37a6 <vprintf+0x60>
        s = va_arg(ap, char*);
    38a0:	008b0993          	addi	s3,s6,8
    38a4:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    38a8:	02090163          	beqz	s2,38ca <vprintf+0x184>
        while(*s != 0){
    38ac:	00094583          	lbu	a1,0(s2)
    38b0:	c9a1                	beqz	a1,3900 <vprintf+0x1ba>
          putc(fd, *s);
    38b2:	8556                	mv	a0,s5
    38b4:	00000097          	auipc	ra,0x0
    38b8:	dc6080e7          	jalr	-570(ra) # 367a <putc>
          s++;
    38bc:	0905                	addi	s2,s2,1
        while(*s != 0){
    38be:	00094583          	lbu	a1,0(s2)
    38c2:	f9e5                	bnez	a1,38b2 <vprintf+0x16c>
        s = va_arg(ap, char*);
    38c4:	8b4e                	mv	s6,s3
      state = 0;
    38c6:	4981                	li	s3,0
    38c8:	bdf9                	j	37a6 <vprintf+0x60>
          s = "(null)";
    38ca:	00000917          	auipc	s2,0x0
    38ce:	33690913          	addi	s2,s2,822 # 3c00 <malloc+0x1f0>
        while(*s != 0){
    38d2:	02800593          	li	a1,40
    38d6:	bff1                	j	38b2 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    38d8:	008b0913          	addi	s2,s6,8
    38dc:	000b4583          	lbu	a1,0(s6)
    38e0:	8556                	mv	a0,s5
    38e2:	00000097          	auipc	ra,0x0
    38e6:	d98080e7          	jalr	-616(ra) # 367a <putc>
    38ea:	8b4a                	mv	s6,s2
      state = 0;
    38ec:	4981                	li	s3,0
    38ee:	bd65                	j	37a6 <vprintf+0x60>
        putc(fd, c);
    38f0:	85d2                	mv	a1,s4
    38f2:	8556                	mv	a0,s5
    38f4:	00000097          	auipc	ra,0x0
    38f8:	d86080e7          	jalr	-634(ra) # 367a <putc>
      state = 0;
    38fc:	4981                	li	s3,0
    38fe:	b565                	j	37a6 <vprintf+0x60>
        s = va_arg(ap, char*);
    3900:	8b4e                	mv	s6,s3
      state = 0;
    3902:	4981                	li	s3,0
    3904:	b54d                	j	37a6 <vprintf+0x60>
    }
  }
}
    3906:	70e6                	ld	ra,120(sp)
    3908:	7446                	ld	s0,112(sp)
    390a:	74a6                	ld	s1,104(sp)
    390c:	7906                	ld	s2,96(sp)
    390e:	69e6                	ld	s3,88(sp)
    3910:	6a46                	ld	s4,80(sp)
    3912:	6aa6                	ld	s5,72(sp)
    3914:	6b06                	ld	s6,64(sp)
    3916:	7be2                	ld	s7,56(sp)
    3918:	7c42                	ld	s8,48(sp)
    391a:	7ca2                	ld	s9,40(sp)
    391c:	7d02                	ld	s10,32(sp)
    391e:	6de2                	ld	s11,24(sp)
    3920:	6109                	addi	sp,sp,128
    3922:	8082                	ret

0000000000003924 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    3924:	715d                	addi	sp,sp,-80
    3926:	ec06                	sd	ra,24(sp)
    3928:	e822                	sd	s0,16(sp)
    392a:	1000                	addi	s0,sp,32
    392c:	e010                	sd	a2,0(s0)
    392e:	e414                	sd	a3,8(s0)
    3930:	e818                	sd	a4,16(s0)
    3932:	ec1c                	sd	a5,24(s0)
    3934:	03043023          	sd	a6,32(s0)
    3938:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    393c:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    3940:	8622                	mv	a2,s0
    3942:	00000097          	auipc	ra,0x0
    3946:	e04080e7          	jalr	-508(ra) # 3746 <vprintf>
}
    394a:	60e2                	ld	ra,24(sp)
    394c:	6442                	ld	s0,16(sp)
    394e:	6161                	addi	sp,sp,80
    3950:	8082                	ret

0000000000003952 <printf>:

void
printf(const char *fmt, ...)
{
    3952:	711d                	addi	sp,sp,-96
    3954:	ec06                	sd	ra,24(sp)
    3956:	e822                	sd	s0,16(sp)
    3958:	1000                	addi	s0,sp,32
    395a:	e40c                	sd	a1,8(s0)
    395c:	e810                	sd	a2,16(s0)
    395e:	ec14                	sd	a3,24(s0)
    3960:	f018                	sd	a4,32(s0)
    3962:	f41c                	sd	a5,40(s0)
    3964:	03043823          	sd	a6,48(s0)
    3968:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    396c:	00840613          	addi	a2,s0,8
    3970:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    3974:	85aa                	mv	a1,a0
    3976:	4505                	li	a0,1
    3978:	00000097          	auipc	ra,0x0
    397c:	dce080e7          	jalr	-562(ra) # 3746 <vprintf>
}
    3980:	60e2                	ld	ra,24(sp)
    3982:	6442                	ld	s0,16(sp)
    3984:	6125                	addi	sp,sp,96
    3986:	8082                	ret

0000000000003988 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3988:	1141                	addi	sp,sp,-16
    398a:	e422                	sd	s0,8(sp)
    398c:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    398e:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3992:	00000797          	auipc	a5,0x0
    3996:	66e7b783          	ld	a5,1646(a5) # 4000 <freep>
    399a:	a805                	j	39ca <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    399c:	4618                	lw	a4,8(a2)
    399e:	9db9                	addw	a1,a1,a4
    39a0:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    39a4:	6398                	ld	a4,0(a5)
    39a6:	6318                	ld	a4,0(a4)
    39a8:	fee53823          	sd	a4,-16(a0)
    39ac:	a091                	j	39f0 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    39ae:	ff852703          	lw	a4,-8(a0)
    39b2:	9e39                	addw	a2,a2,a4
    39b4:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    39b6:	ff053703          	ld	a4,-16(a0)
    39ba:	e398                	sd	a4,0(a5)
    39bc:	a099                	j	3a02 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    39be:	6398                	ld	a4,0(a5)
    39c0:	00e7e463          	bltu	a5,a4,39c8 <free+0x40>
    39c4:	00e6ea63          	bltu	a3,a4,39d8 <free+0x50>
{
    39c8:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    39ca:	fed7fae3          	bgeu	a5,a3,39be <free+0x36>
    39ce:	6398                	ld	a4,0(a5)
    39d0:	00e6e463          	bltu	a3,a4,39d8 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    39d4:	fee7eae3          	bltu	a5,a4,39c8 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    39d8:	ff852583          	lw	a1,-8(a0)
    39dc:	6390                	ld	a2,0(a5)
    39de:	02059713          	slli	a4,a1,0x20
    39e2:	9301                	srli	a4,a4,0x20
    39e4:	0712                	slli	a4,a4,0x4
    39e6:	9736                	add	a4,a4,a3
    39e8:	fae60ae3          	beq	a2,a4,399c <free+0x14>
    bp->s.ptr = p->s.ptr;
    39ec:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    39f0:	4790                	lw	a2,8(a5)
    39f2:	02061713          	slli	a4,a2,0x20
    39f6:	9301                	srli	a4,a4,0x20
    39f8:	0712                	slli	a4,a4,0x4
    39fa:	973e                	add	a4,a4,a5
    39fc:	fae689e3          	beq	a3,a4,39ae <free+0x26>
  } else
    p->s.ptr = bp;
    3a00:	e394                	sd	a3,0(a5)
  freep = p;
    3a02:	00000717          	auipc	a4,0x0
    3a06:	5ef73f23          	sd	a5,1534(a4) # 4000 <freep>
}
    3a0a:	6422                	ld	s0,8(sp)
    3a0c:	0141                	addi	sp,sp,16
    3a0e:	8082                	ret

0000000000003a10 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3a10:	7139                	addi	sp,sp,-64
    3a12:	fc06                	sd	ra,56(sp)
    3a14:	f822                	sd	s0,48(sp)
    3a16:	f426                	sd	s1,40(sp)
    3a18:	f04a                	sd	s2,32(sp)
    3a1a:	ec4e                	sd	s3,24(sp)
    3a1c:	e852                	sd	s4,16(sp)
    3a1e:	e456                	sd	s5,8(sp)
    3a20:	e05a                	sd	s6,0(sp)
    3a22:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3a24:	02051493          	slli	s1,a0,0x20
    3a28:	9081                	srli	s1,s1,0x20
    3a2a:	04bd                	addi	s1,s1,15
    3a2c:	8091                	srli	s1,s1,0x4
    3a2e:	0014899b          	addiw	s3,s1,1
    3a32:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    3a34:	00000517          	auipc	a0,0x0
    3a38:	5cc53503          	ld	a0,1484(a0) # 4000 <freep>
    3a3c:	c515                	beqz	a0,3a68 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3a3e:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3a40:	4798                	lw	a4,8(a5)
    3a42:	02977f63          	bgeu	a4,s1,3a80 <malloc+0x70>
    3a46:	8a4e                	mv	s4,s3
    3a48:	0009871b          	sext.w	a4,s3
    3a4c:	6685                	lui	a3,0x1
    3a4e:	00d77363          	bgeu	a4,a3,3a54 <malloc+0x44>
    3a52:	6a05                	lui	s4,0x1
    3a54:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    3a58:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3a5c:	00000917          	auipc	s2,0x0
    3a60:	5a490913          	addi	s2,s2,1444 # 4000 <freep>
  if(p == (char*)-1)
    3a64:	5afd                	li	s5,-1
    3a66:	a88d                	j	3ad8 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    3a68:	00000797          	auipc	a5,0x0
    3a6c:	5a878793          	addi	a5,a5,1448 # 4010 <base>
    3a70:	00000717          	auipc	a4,0x0
    3a74:	58f73823          	sd	a5,1424(a4) # 4000 <freep>
    3a78:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    3a7a:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    3a7e:	b7e1                	j	3a46 <malloc+0x36>
      if(p->s.size == nunits)
    3a80:	02e48b63          	beq	s1,a4,3ab6 <malloc+0xa6>
        p->s.size -= nunits;
    3a84:	4137073b          	subw	a4,a4,s3
    3a88:	c798                	sw	a4,8(a5)
        p += p->s.size;
    3a8a:	1702                	slli	a4,a4,0x20
    3a8c:	9301                	srli	a4,a4,0x20
    3a8e:	0712                	slli	a4,a4,0x4
    3a90:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    3a92:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    3a96:	00000717          	auipc	a4,0x0
    3a9a:	56a73523          	sd	a0,1386(a4) # 4000 <freep>
      return (void*)(p + 1);
    3a9e:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3aa2:	70e2                	ld	ra,56(sp)
    3aa4:	7442                	ld	s0,48(sp)
    3aa6:	74a2                	ld	s1,40(sp)
    3aa8:	7902                	ld	s2,32(sp)
    3aaa:	69e2                	ld	s3,24(sp)
    3aac:	6a42                	ld	s4,16(sp)
    3aae:	6aa2                	ld	s5,8(sp)
    3ab0:	6b02                	ld	s6,0(sp)
    3ab2:	6121                	addi	sp,sp,64
    3ab4:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    3ab6:	6398                	ld	a4,0(a5)
    3ab8:	e118                	sd	a4,0(a0)
    3aba:	bff1                	j	3a96 <malloc+0x86>
  hp->s.size = nu;
    3abc:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    3ac0:	0541                	addi	a0,a0,16
    3ac2:	00000097          	auipc	ra,0x0
    3ac6:	ec6080e7          	jalr	-314(ra) # 3988 <free>
  return freep;
    3aca:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    3ace:	d971                	beqz	a0,3aa2 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3ad0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3ad2:	4798                	lw	a4,8(a5)
    3ad4:	fa9776e3          	bgeu	a4,s1,3a80 <malloc+0x70>
    if(p == freep)
    3ad8:	00093703          	ld	a4,0(s2)
    3adc:	853e                	mv	a0,a5
    3ade:	fef719e3          	bne	a4,a5,3ad0 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3ae2:	8552                	mv	a0,s4
    3ae4:	00000097          	auipc	ra,0x0
    3ae8:	b56080e7          	jalr	-1194(ra) # 363a <sbrk>
  if(p == (char*)-1)
    3aec:	fd5518e3          	bne	a0,s5,3abc <malloc+0xac>
        return 0;
    3af0:	4501                	li	a0,0
    3af2:	bf45                	j	3aa2 <malloc+0x92>
