
user/_head_k:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <main>:
#include "user/user.h"

#define BUF_SIZE      512
#define DEFAULT_LINES  14

int main(int argc, char *argv[]) {
    3000:	db010113          	addi	sp,sp,-592
    3004:	24113423          	sd	ra,584(sp)
    3008:	24813023          	sd	s0,576(sp)
    300c:	22913c23          	sd	s1,568(sp)
    3010:	23213823          	sd	s2,560(sp)
    3014:	23313423          	sd	s3,552(sp)
    3018:	23413023          	sd	s4,544(sp)
    301c:	21513c23          	sd	s5,536(sp)
    3020:	21613823          	sd	s6,528(sp)
    3024:	21713423          	sd	s7,520(sp)
    3028:	21813023          	sd	s8,512(sp)
    302c:	0c80                	addi	s0,sp,592
    302e:	8a2a                	mv	s4,a0
    3030:	84ae                	mv	s1,a1
  int fd, i = 1, j, count = DEFAULT_LINES;  
  char buf[BUF_SIZE]; 

  printf("Head command is getting executed in user mode.\n"); 
    3032:	00001517          	auipc	a0,0x1
    3036:	9ee50513          	addi	a0,a0,-1554 # 3a20 <malloc+0xe6>
    303a:	00001097          	auipc	ra,0x1
    303e:	842080e7          	jalr	-1982(ra) # 387c <printf>

  // check for default head vs numbered head
  if (!strcmp(argv[1], "-n")) {
    3042:	00001597          	auipc	a1,0x1
    3046:	a0e58593          	addi	a1,a1,-1522 # 3a50 <malloc+0x116>
    304a:	6488                	ld	a0,8(s1)
    304c:	00000097          	auipc	ra,0x0
    3050:	1de080e7          	jalr	478(ra) # 322a <strcmp>
    3054:	e929                	bnez	a0,30a6 <main+0xa6>
    for (j = 0; argv[2][j] != '\0'; j++) {
    3056:	6888                	ld	a0,16(s1)
    3058:	00054783          	lbu	a5,0(a0)
    305c:	c385                	beqz	a5,307c <main+0x7c>
    305e:	4905                	li	s2,1
      if (!isDigit(&argv[2][j])) {
    3060:	00000097          	auipc	ra,0x0
    3064:	450080e7          	jalr	1104(ra) # 34b0 <isDigit>
    3068:	2501                	sext.w	a0,a0
    306a:	c105                	beqz	a0,308a <main+0x8a>
    for (j = 0; argv[2][j] != '\0'; j++) {
    306c:	689c                	ld	a5,16(s1)
    306e:	01278533          	add	a0,a5,s2
    3072:	0905                	addi	s2,s2,1
    3074:	00054703          	lbu	a4,0(a0)
    3078:	f765                	bnez	a4,3060 <main+0x60>
    307a:	853e                	mv	a0,a5
        printf("head: invalid number of lines: '%s'\n", argv[2]); 
	exit(1); 
      }
    }
    count = atoi(argv[2]); 
    307c:	00000097          	auipc	ra,0x0
    3080:	304080e7          	jalr	772(ra) # 3380 <atoi>
    3084:	8aaa                	mv	s5,a0
    i = 3;    
    3086:	450d                	li	a0,3
    3088:	a805                	j	30b8 <main+0xb8>
        printf("head: invalid number of lines: '%s'\n", argv[2]); 
    308a:	688c                	ld	a1,16(s1)
    308c:	00001517          	auipc	a0,0x1
    3090:	9cc50513          	addi	a0,a0,-1588 # 3a58 <malloc+0x11e>
    3094:	00000097          	auipc	ra,0x0
    3098:	7e8080e7          	jalr	2024(ra) # 387c <printf>
	exit(1); 
    309c:	4505                	li	a0,1
    309e:	00000097          	auipc	ra,0x0
    30a2:	436080e7          	jalr	1078(ra) # 34d4 <exit>
  }
  else if (argv[1][0] == '-') {
    30a6:	6488                	ld	a0,8(s1)
    30a8:	00054703          	lbu	a4,0(a0)
    30ac:	02d00793          	li	a5,45
    30b0:	02f70c63          	beq	a4,a5,30e8 <main+0xe8>
  int fd, i = 1, j, count = DEFAULT_LINES;  
    30b4:	4ab9                	li	s5,14
    30b6:	4505                	li	a0,1
    if (strlen(num)) 
      count = atoi(num); 
    i = 2;   
  } 
 
  if (i >= argc) 
    30b8:	0b455e63          	bge	a0,s4,3174 <main+0x174>
    head_k(0, (uint64)buf, count);
  else {
    for (j = i; j < argc; j++) {
    30bc:	00351913          	slli	s2,a0,0x3
    30c0:	9926                	add	s2,s2,s1
    30c2:	fffa099b          	addiw	s3,s4,-1
    30c6:	40a989bb          	subw	s3,s3,a0
    30ca:	1982                	slli	s3,s3,0x20
    30cc:	0209d993          	srli	s3,s3,0x20
    30d0:	99aa                	add	s3,s3,a0
    30d2:	098e                	slli	s3,s3,0x3
    30d4:	04a1                	addi	s1,s1,8
    30d6:	99a6                	add	s3,s3,s1
      if ((fd = open(argv[j], 0)) < 0) { 
        printf("head: cannot open '%s' for reading: No such file or directory\n", argv[j]);
        exit(1); 	
      } 
      if (argc - i >= 2) 
    30d8:	40aa0a3b          	subw	s4,s4,a0
    30dc:	4b85                	li	s7,1
        printf("\n==> %s <==\n", argv[j]); 
    30de:	00001c17          	auipc	s8,0x1
    30e2:	a02c0c13          	addi	s8,s8,-1534 # 3ae0 <malloc+0x1a6>
    30e6:	a0dd                	j	31cc <main+0x1cc>
    char *num = malloc(strlen(argv[1])); 
    30e8:	00000097          	auipc	ra,0x0
    30ec:	16e080e7          	jalr	366(ra) # 3256 <strlen>
    30f0:	2501                	sext.w	a0,a0
    30f2:	00001097          	auipc	ra,0x1
    30f6:	848080e7          	jalr	-1976(ra) # 393a <malloc>
    30fa:	89aa                	mv	s3,a0
    for (j = 1; argv[1][j] != '\0'; j++) {
    30fc:	649c                	ld	a5,8(s1)
    30fe:	00178513          	addi	a0,a5,1
    3102:	0017c783          	lbu	a5,1(a5)
    3106:	c795                	beqz	a5,3132 <main+0x132>
    3108:	4905                	li	s2,1
      if (!isDigit(&argv[1][j])) {
    310a:	00000097          	auipc	ra,0x0
    310e:	3a6080e7          	jalr	934(ra) # 34b0 <isDigit>
    3112:	2501                	sext.w	a0,a0
    3114:	c915                	beqz	a0,3148 <main+0x148>
      num[j-1] = argv[1][j];       
    3116:	649c                	ld	a5,8(s1)
    3118:	97ca                	add	a5,a5,s2
    311a:	0007c703          	lbu	a4,0(a5)
    311e:	012987b3          	add	a5,s3,s2
    3122:	fee78fa3          	sb	a4,-1(a5)
    for (j = 1; argv[1][j] != '\0'; j++) {
    3126:	0905                	addi	s2,s2,1
    3128:	6488                	ld	a0,8(s1)
    312a:	954a                	add	a0,a0,s2
    312c:	00054783          	lbu	a5,0(a0)
    3130:	ffe9                	bnez	a5,310a <main+0x10a>
    if (strlen(num)) 
    3132:	854e                	mv	a0,s3
    3134:	00000097          	auipc	ra,0x0
    3138:	122080e7          	jalr	290(ra) # 3256 <strlen>
    313c:	0005079b          	sext.w	a5,a0
    3140:	e395                	bnez	a5,3164 <main+0x164>
  int fd, i = 1, j, count = DEFAULT_LINES;  
    3142:	4ab9                	li	s5,14
    i = 2;   
    3144:	4509                	li	a0,2
    3146:	bf8d                	j	30b8 <main+0xb8>
        printf("head: invalid option %s\n", argv[1]);
    3148:	648c                	ld	a1,8(s1)
    314a:	00001517          	auipc	a0,0x1
    314e:	93650513          	addi	a0,a0,-1738 # 3a80 <malloc+0x146>
    3152:	00000097          	auipc	ra,0x0
    3156:	72a080e7          	jalr	1834(ra) # 387c <printf>
	exit(1);
    315a:	4505                	li	a0,1
    315c:	00000097          	auipc	ra,0x0
    3160:	378080e7          	jalr	888(ra) # 34d4 <exit>
      count = atoi(num); 
    3164:	854e                	mv	a0,s3
    3166:	00000097          	auipc	ra,0x0
    316a:	21a080e7          	jalr	538(ra) # 3380 <atoi>
    316e:	8aaa                	mv	s5,a0
    i = 2;   
    3170:	4509                	li	a0,2
    3172:	b799                	j	30b8 <main+0xb8>
    head_k(0, (uint64)buf, count);
    3174:	8656                	mv	a2,s5
    3176:	db040593          	addi	a1,s0,-592
    317a:	4501                	li	a0,0
    317c:	00000097          	auipc	ra,0x0
    3180:	408080e7          	jalr	1032(ra) # 3584 <head_k>
      head_k(fd, (uint64)buf, count);        
      close(fd); 
    }
  } 
  exit(0); 
    3184:	4501                	li	a0,0
    3186:	00000097          	auipc	ra,0x0
    318a:	34e080e7          	jalr	846(ra) # 34d4 <exit>
        printf("head: cannot open '%s' for reading: No such file or directory\n", argv[j]);
    318e:	00093583          	ld	a1,0(s2)
    3192:	00001517          	auipc	a0,0x1
    3196:	90e50513          	addi	a0,a0,-1778 # 3aa0 <malloc+0x166>
    319a:	00000097          	auipc	ra,0x0
    319e:	6e2080e7          	jalr	1762(ra) # 387c <printf>
        exit(1); 	
    31a2:	4505                	li	a0,1
    31a4:	00000097          	auipc	ra,0x0
    31a8:	330080e7          	jalr	816(ra) # 34d4 <exit>
      head_k(fd, (uint64)buf, count);        
    31ac:	8656                	mv	a2,s5
    31ae:	db040593          	addi	a1,s0,-592
    31b2:	8526                	mv	a0,s1
    31b4:	00000097          	auipc	ra,0x0
    31b8:	3d0080e7          	jalr	976(ra) # 3584 <head_k>
      close(fd); 
    31bc:	8526                	mv	a0,s1
    31be:	00000097          	auipc	ra,0x0
    31c2:	346080e7          	jalr	838(ra) # 3504 <close>
    for (j = i; j < argc; j++) {
    31c6:	0921                	addi	s2,s2,8
    31c8:	fb390ee3          	beq	s2,s3,3184 <main+0x184>
      if ((fd = open(argv[j], 0)) < 0) { 
    31cc:	4581                	li	a1,0
    31ce:	00093503          	ld	a0,0(s2)
    31d2:	00000097          	auipc	ra,0x0
    31d6:	34a080e7          	jalr	842(ra) # 351c <open>
    31da:	84aa                	mv	s1,a0
    31dc:	fa0549e3          	bltz	a0,318e <main+0x18e>
      if (argc - i >= 2) 
    31e0:	fd4bd6e3          	bge	s7,s4,31ac <main+0x1ac>
        printf("\n==> %s <==\n", argv[j]); 
    31e4:	00093583          	ld	a1,0(s2)
    31e8:	8562                	mv	a0,s8
    31ea:	00000097          	auipc	ra,0x0
    31ee:	692080e7          	jalr	1682(ra) # 387c <printf>
    31f2:	bf6d                	j	31ac <main+0x1ac>

00000000000031f4 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    31f4:	1141                	addi	sp,sp,-16
    31f6:	e406                	sd	ra,8(sp)
    31f8:	e022                	sd	s0,0(sp)
    31fa:	0800                	addi	s0,sp,16
  extern int main();
  main();
    31fc:	00000097          	auipc	ra,0x0
    3200:	e04080e7          	jalr	-508(ra) # 3000 <main>
  exit(0);
    3204:	4501                	li	a0,0
    3206:	00000097          	auipc	ra,0x0
    320a:	2ce080e7          	jalr	718(ra) # 34d4 <exit>

000000000000320e <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    320e:	1141                	addi	sp,sp,-16
    3210:	e422                	sd	s0,8(sp)
    3212:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3214:	87aa                	mv	a5,a0
    3216:	0585                	addi	a1,a1,1
    3218:	0785                	addi	a5,a5,1
    321a:	fff5c703          	lbu	a4,-1(a1)
    321e:	fee78fa3          	sb	a4,-1(a5)
    3222:	fb75                	bnez	a4,3216 <strcpy+0x8>
    ;
  return os;
}
    3224:	6422                	ld	s0,8(sp)
    3226:	0141                	addi	sp,sp,16
    3228:	8082                	ret

000000000000322a <strcmp>:

int
strcmp(const char *p, const char *q)
{
    322a:	1141                	addi	sp,sp,-16
    322c:	e422                	sd	s0,8(sp)
    322e:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    3230:	00054783          	lbu	a5,0(a0)
    3234:	cb91                	beqz	a5,3248 <strcmp+0x1e>
    3236:	0005c703          	lbu	a4,0(a1)
    323a:	00f71763          	bne	a4,a5,3248 <strcmp+0x1e>
    p++, q++;
    323e:	0505                	addi	a0,a0,1
    3240:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    3242:	00054783          	lbu	a5,0(a0)
    3246:	fbe5                	bnez	a5,3236 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    3248:	0005c503          	lbu	a0,0(a1)
}
    324c:	40a7853b          	subw	a0,a5,a0
    3250:	6422                	ld	s0,8(sp)
    3252:	0141                	addi	sp,sp,16
    3254:	8082                	ret

0000000000003256 <strlen>:

uint
strlen(const char *s)
{
    3256:	1141                	addi	sp,sp,-16
    3258:	e422                	sd	s0,8(sp)
    325a:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    325c:	00054783          	lbu	a5,0(a0)
    3260:	cf91                	beqz	a5,327c <strlen+0x26>
    3262:	0505                	addi	a0,a0,1
    3264:	87aa                	mv	a5,a0
    3266:	4685                	li	a3,1
    3268:	9e89                	subw	a3,a3,a0
    326a:	00f6853b          	addw	a0,a3,a5
    326e:	0785                	addi	a5,a5,1
    3270:	fff7c703          	lbu	a4,-1(a5)
    3274:	fb7d                	bnez	a4,326a <strlen+0x14>
    ;
  return n;
}
    3276:	6422                	ld	s0,8(sp)
    3278:	0141                	addi	sp,sp,16
    327a:	8082                	ret
  for(n = 0; s[n]; n++)
    327c:	4501                	li	a0,0
    327e:	bfe5                	j	3276 <strlen+0x20>

0000000000003280 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3280:	1141                	addi	sp,sp,-16
    3282:	e422                	sd	s0,8(sp)
    3284:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    3286:	ca19                	beqz	a2,329c <memset+0x1c>
    3288:	87aa                	mv	a5,a0
    328a:	1602                	slli	a2,a2,0x20
    328c:	9201                	srli	a2,a2,0x20
    328e:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    3292:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    3296:	0785                	addi	a5,a5,1
    3298:	fee79de3          	bne	a5,a4,3292 <memset+0x12>
  }
  return dst;
}
    329c:	6422                	ld	s0,8(sp)
    329e:	0141                	addi	sp,sp,16
    32a0:	8082                	ret

00000000000032a2 <strchr>:

char*
strchr(const char *s, char c)
{
    32a2:	1141                	addi	sp,sp,-16
    32a4:	e422                	sd	s0,8(sp)
    32a6:	0800                	addi	s0,sp,16
  for(; *s; s++)
    32a8:	00054783          	lbu	a5,0(a0)
    32ac:	cb99                	beqz	a5,32c2 <strchr+0x20>
    if(*s == c)
    32ae:	00f58763          	beq	a1,a5,32bc <strchr+0x1a>
  for(; *s; s++)
    32b2:	0505                	addi	a0,a0,1
    32b4:	00054783          	lbu	a5,0(a0)
    32b8:	fbfd                	bnez	a5,32ae <strchr+0xc>
      return (char*)s;
  return 0;
    32ba:	4501                	li	a0,0
}
    32bc:	6422                	ld	s0,8(sp)
    32be:	0141                	addi	sp,sp,16
    32c0:	8082                	ret
  return 0;
    32c2:	4501                	li	a0,0
    32c4:	bfe5                	j	32bc <strchr+0x1a>

00000000000032c6 <gets>:

char*
gets(char *buf, int max)
{
    32c6:	711d                	addi	sp,sp,-96
    32c8:	ec86                	sd	ra,88(sp)
    32ca:	e8a2                	sd	s0,80(sp)
    32cc:	e4a6                	sd	s1,72(sp)
    32ce:	e0ca                	sd	s2,64(sp)
    32d0:	fc4e                	sd	s3,56(sp)
    32d2:	f852                	sd	s4,48(sp)
    32d4:	f456                	sd	s5,40(sp)
    32d6:	f05a                	sd	s6,32(sp)
    32d8:	ec5e                	sd	s7,24(sp)
    32da:	1080                	addi	s0,sp,96
    32dc:	8baa                	mv	s7,a0
    32de:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    32e0:	892a                	mv	s2,a0
    32e2:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    32e4:	4aa9                	li	s5,10
    32e6:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    32e8:	89a6                	mv	s3,s1
    32ea:	2485                	addiw	s1,s1,1
    32ec:	0344d863          	bge	s1,s4,331c <gets+0x56>
    cc = read(0, &c, 1);
    32f0:	4605                	li	a2,1
    32f2:	faf40593          	addi	a1,s0,-81
    32f6:	4501                	li	a0,0
    32f8:	00000097          	auipc	ra,0x0
    32fc:	1fc080e7          	jalr	508(ra) # 34f4 <read>
    if(cc < 1)
    3300:	00a05e63          	blez	a0,331c <gets+0x56>
    buf[i++] = c;
    3304:	faf44783          	lbu	a5,-81(s0)
    3308:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    330c:	01578763          	beq	a5,s5,331a <gets+0x54>
    3310:	0905                	addi	s2,s2,1
    3312:	fd679be3          	bne	a5,s6,32e8 <gets+0x22>
  for(i=0; i+1 < max; ){
    3316:	89a6                	mv	s3,s1
    3318:	a011                	j	331c <gets+0x56>
    331a:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    331c:	99de                	add	s3,s3,s7
    331e:	00098023          	sb	zero,0(s3)
  return buf;
}
    3322:	855e                	mv	a0,s7
    3324:	60e6                	ld	ra,88(sp)
    3326:	6446                	ld	s0,80(sp)
    3328:	64a6                	ld	s1,72(sp)
    332a:	6906                	ld	s2,64(sp)
    332c:	79e2                	ld	s3,56(sp)
    332e:	7a42                	ld	s4,48(sp)
    3330:	7aa2                	ld	s5,40(sp)
    3332:	7b02                	ld	s6,32(sp)
    3334:	6be2                	ld	s7,24(sp)
    3336:	6125                	addi	sp,sp,96
    3338:	8082                	ret

000000000000333a <stat>:

int
stat(const char *n, struct stat *st)
{
    333a:	1101                	addi	sp,sp,-32
    333c:	ec06                	sd	ra,24(sp)
    333e:	e822                	sd	s0,16(sp)
    3340:	e426                	sd	s1,8(sp)
    3342:	e04a                	sd	s2,0(sp)
    3344:	1000                	addi	s0,sp,32
    3346:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3348:	4581                	li	a1,0
    334a:	00000097          	auipc	ra,0x0
    334e:	1d2080e7          	jalr	466(ra) # 351c <open>
  if(fd < 0)
    3352:	02054563          	bltz	a0,337c <stat+0x42>
    3356:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    3358:	85ca                	mv	a1,s2
    335a:	00000097          	auipc	ra,0x0
    335e:	1da080e7          	jalr	474(ra) # 3534 <fstat>
    3362:	892a                	mv	s2,a0
  close(fd);
    3364:	8526                	mv	a0,s1
    3366:	00000097          	auipc	ra,0x0
    336a:	19e080e7          	jalr	414(ra) # 3504 <close>
  return r;
}
    336e:	854a                	mv	a0,s2
    3370:	60e2                	ld	ra,24(sp)
    3372:	6442                	ld	s0,16(sp)
    3374:	64a2                	ld	s1,8(sp)
    3376:	6902                	ld	s2,0(sp)
    3378:	6105                	addi	sp,sp,32
    337a:	8082                	ret
    return -1;
    337c:	597d                	li	s2,-1
    337e:	bfc5                	j	336e <stat+0x34>

0000000000003380 <atoi>:

int
atoi(const char *s)
{
    3380:	1141                	addi	sp,sp,-16
    3382:	e422                	sd	s0,8(sp)
    3384:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3386:	00054603          	lbu	a2,0(a0)
    338a:	fd06079b          	addiw	a5,a2,-48
    338e:	0ff7f793          	andi	a5,a5,255
    3392:	4725                	li	a4,9
    3394:	02f76963          	bltu	a4,a5,33c6 <atoi+0x46>
    3398:	86aa                	mv	a3,a0
  n = 0;
    339a:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    339c:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    339e:	0685                	addi	a3,a3,1
    33a0:	0025179b          	slliw	a5,a0,0x2
    33a4:	9fa9                	addw	a5,a5,a0
    33a6:	0017979b          	slliw	a5,a5,0x1
    33aa:	9fb1                	addw	a5,a5,a2
    33ac:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    33b0:	0006c603          	lbu	a2,0(a3)
    33b4:	fd06071b          	addiw	a4,a2,-48
    33b8:	0ff77713          	andi	a4,a4,255
    33bc:	fee5f1e3          	bgeu	a1,a4,339e <atoi+0x1e>
  return n;
}
    33c0:	6422                	ld	s0,8(sp)
    33c2:	0141                	addi	sp,sp,16
    33c4:	8082                	ret
  n = 0;
    33c6:	4501                	li	a0,0
    33c8:	bfe5                	j	33c0 <atoi+0x40>

00000000000033ca <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    33ca:	1141                	addi	sp,sp,-16
    33cc:	e422                	sd	s0,8(sp)
    33ce:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    33d0:	02b57463          	bgeu	a0,a1,33f8 <memmove+0x2e>
    while(n-- > 0)
    33d4:	00c05f63          	blez	a2,33f2 <memmove+0x28>
    33d8:	1602                	slli	a2,a2,0x20
    33da:	9201                	srli	a2,a2,0x20
    33dc:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    33e0:	872a                	mv	a4,a0
      *dst++ = *src++;
    33e2:	0585                	addi	a1,a1,1
    33e4:	0705                	addi	a4,a4,1
    33e6:	fff5c683          	lbu	a3,-1(a1)
    33ea:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    33ee:	fee79ae3          	bne	a5,a4,33e2 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    33f2:	6422                	ld	s0,8(sp)
    33f4:	0141                	addi	sp,sp,16
    33f6:	8082                	ret
    dst += n;
    33f8:	00c50733          	add	a4,a0,a2
    src += n;
    33fc:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    33fe:	fec05ae3          	blez	a2,33f2 <memmove+0x28>
    3402:	fff6079b          	addiw	a5,a2,-1
    3406:	1782                	slli	a5,a5,0x20
    3408:	9381                	srli	a5,a5,0x20
    340a:	fff7c793          	not	a5,a5
    340e:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    3410:	15fd                	addi	a1,a1,-1
    3412:	177d                	addi	a4,a4,-1
    3414:	0005c683          	lbu	a3,0(a1)
    3418:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    341c:	fee79ae3          	bne	a5,a4,3410 <memmove+0x46>
    3420:	bfc9                	j	33f2 <memmove+0x28>

0000000000003422 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    3422:	1141                	addi	sp,sp,-16
    3424:	e422                	sd	s0,8(sp)
    3426:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    3428:	ca05                	beqz	a2,3458 <memcmp+0x36>
    342a:	fff6069b          	addiw	a3,a2,-1
    342e:	1682                	slli	a3,a3,0x20
    3430:	9281                	srli	a3,a3,0x20
    3432:	0685                	addi	a3,a3,1
    3434:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    3436:	00054783          	lbu	a5,0(a0)
    343a:	0005c703          	lbu	a4,0(a1)
    343e:	00e79863          	bne	a5,a4,344e <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    3442:	0505                	addi	a0,a0,1
    p2++;
    3444:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    3446:	fed518e3          	bne	a0,a3,3436 <memcmp+0x14>
  }
  return 0;
    344a:	4501                	li	a0,0
    344c:	a019                	j	3452 <memcmp+0x30>
      return *p1 - *p2;
    344e:	40e7853b          	subw	a0,a5,a4
}
    3452:	6422                	ld	s0,8(sp)
    3454:	0141                	addi	sp,sp,16
    3456:	8082                	ret
  return 0;
    3458:	4501                	li	a0,0
    345a:	bfe5                	j	3452 <memcmp+0x30>

000000000000345c <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    345c:	1141                	addi	sp,sp,-16
    345e:	e406                	sd	ra,8(sp)
    3460:	e022                	sd	s0,0(sp)
    3462:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    3464:	00000097          	auipc	ra,0x0
    3468:	f66080e7          	jalr	-154(ra) # 33ca <memmove>
}
    346c:	60a2                	ld	ra,8(sp)
    346e:	6402                	ld	s0,0(sp)
    3470:	0141                	addi	sp,sp,16
    3472:	8082                	ret

0000000000003474 <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    3474:	1141                	addi	sp,sp,-16
    3476:	e422                	sd	s0,8(sp)
    3478:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    347a:	00052023          	sw	zero,0(a0)
}  
    347e:	6422                	ld	s0,8(sp)
    3480:	0141                	addi	sp,sp,16
    3482:	8082                	ret

0000000000003484 <lock>:

void lock(struct spinlock * lk) 
{    
    3484:	1141                	addi	sp,sp,-16
    3486:	e422                	sd	s0,8(sp)
    3488:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    348a:	4705                	li	a4,1
    348c:	87ba                	mv	a5,a4
    348e:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    3492:	2781                	sext.w	a5,a5
    3494:	ffe5                	bnez	a5,348c <lock+0x8>
}  
    3496:	6422                	ld	s0,8(sp)
    3498:	0141                	addi	sp,sp,16
    349a:	8082                	ret

000000000000349c <unlock>:

void unlock(struct spinlock * lk) 
{   
    349c:	1141                	addi	sp,sp,-16
    349e:	e422                	sd	s0,8(sp)
    34a0:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    34a2:	0f50000f          	fence	iorw,ow
    34a6:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    34aa:	6422                	ld	s0,8(sp)
    34ac:	0141                	addi	sp,sp,16
    34ae:	8082                	ret

00000000000034b0 <isDigit>:

unsigned int isDigit(char *c) {
    34b0:	1141                	addi	sp,sp,-16
    34b2:	e422                	sd	s0,8(sp)
    34b4:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    34b6:	00054503          	lbu	a0,0(a0)
    34ba:	fd05051b          	addiw	a0,a0,-48
    34be:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    34c2:	00a53513          	sltiu	a0,a0,10
    34c6:	6422                	ld	s0,8(sp)
    34c8:	0141                	addi	sp,sp,16
    34ca:	8082                	ret

00000000000034cc <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    34cc:	4885                	li	a7,1
 ecall
    34ce:	00000073          	ecall
 ret
    34d2:	8082                	ret

00000000000034d4 <exit>:
.global exit
exit:
 li a7, SYS_exit
    34d4:	4889                	li	a7,2
 ecall
    34d6:	00000073          	ecall
 ret
    34da:	8082                	ret

00000000000034dc <wait>:
.global wait
wait:
 li a7, SYS_wait
    34dc:	488d                	li	a7,3
 ecall
    34de:	00000073          	ecall
 ret
    34e2:	8082                	ret

00000000000034e4 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    34e4:	48e1                	li	a7,24
 ecall
    34e6:	00000073          	ecall
 ret
    34ea:	8082                	ret

00000000000034ec <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    34ec:	4891                	li	a7,4
 ecall
    34ee:	00000073          	ecall
 ret
    34f2:	8082                	ret

00000000000034f4 <read>:
.global read
read:
 li a7, SYS_read
    34f4:	4895                	li	a7,5
 ecall
    34f6:	00000073          	ecall
 ret
    34fa:	8082                	ret

00000000000034fc <write>:
.global write
write:
 li a7, SYS_write
    34fc:	48c1                	li	a7,16
 ecall
    34fe:	00000073          	ecall
 ret
    3502:	8082                	ret

0000000000003504 <close>:
.global close
close:
 li a7, SYS_close
    3504:	48d5                	li	a7,21
 ecall
    3506:	00000073          	ecall
 ret
    350a:	8082                	ret

000000000000350c <kill>:
.global kill
kill:
 li a7, SYS_kill
    350c:	4899                	li	a7,6
 ecall
    350e:	00000073          	ecall
 ret
    3512:	8082                	ret

0000000000003514 <exec>:
.global exec
exec:
 li a7, SYS_exec
    3514:	489d                	li	a7,7
 ecall
    3516:	00000073          	ecall
 ret
    351a:	8082                	ret

000000000000351c <open>:
.global open
open:
 li a7, SYS_open
    351c:	48bd                	li	a7,15
 ecall
    351e:	00000073          	ecall
 ret
    3522:	8082                	ret

0000000000003524 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    3524:	48c5                	li	a7,17
 ecall
    3526:	00000073          	ecall
 ret
    352a:	8082                	ret

000000000000352c <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    352c:	48c9                	li	a7,18
 ecall
    352e:	00000073          	ecall
 ret
    3532:	8082                	ret

0000000000003534 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    3534:	48a1                	li	a7,8
 ecall
    3536:	00000073          	ecall
 ret
    353a:	8082                	ret

000000000000353c <link>:
.global link
link:
 li a7, SYS_link
    353c:	48cd                	li	a7,19
 ecall
    353e:	00000073          	ecall
 ret
    3542:	8082                	ret

0000000000003544 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    3544:	48d1                	li	a7,20
 ecall
    3546:	00000073          	ecall
 ret
    354a:	8082                	ret

000000000000354c <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    354c:	48a5                	li	a7,9
 ecall
    354e:	00000073          	ecall
 ret
    3552:	8082                	ret

0000000000003554 <dup>:
.global dup
dup:
 li a7, SYS_dup
    3554:	48a9                	li	a7,10
 ecall
    3556:	00000073          	ecall
 ret
    355a:	8082                	ret

000000000000355c <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    355c:	48ad                	li	a7,11
 ecall
    355e:	00000073          	ecall
 ret
    3562:	8082                	ret

0000000000003564 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    3564:	48b1                	li	a7,12
 ecall
    3566:	00000073          	ecall
 ret
    356a:	8082                	ret

000000000000356c <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    356c:	48b5                	li	a7,13
 ecall
    356e:	00000073          	ecall
 ret
    3572:	8082                	ret

0000000000003574 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    3574:	48b9                	li	a7,14
 ecall
    3576:	00000073          	ecall
 ret
    357a:	8082                	ret

000000000000357c <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    357c:	48d9                	li	a7,22
 ecall
    357e:	00000073          	ecall
 ret
    3582:	8082                	ret

0000000000003584 <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    3584:	48dd                	li	a7,23
 ecall
    3586:	00000073          	ecall
 ret
    358a:	8082                	ret

000000000000358c <ps>:
.global ps
ps:
 li a7, SYS_ps
    358c:	48e5                	li	a7,25
 ecall
    358e:	00000073          	ecall
 ret
    3592:	8082                	ret

0000000000003594 <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    3594:	48e9                	li	a7,26
 ecall
    3596:	00000073          	ecall
 ret
    359a:	8082                	ret

000000000000359c <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    359c:	48ed                	li	a7,27
 ecall
    359e:	00000073          	ecall
 ret
    35a2:	8082                	ret

00000000000035a4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    35a4:	1101                	addi	sp,sp,-32
    35a6:	ec06                	sd	ra,24(sp)
    35a8:	e822                	sd	s0,16(sp)
    35aa:	1000                	addi	s0,sp,32
    35ac:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    35b0:	4605                	li	a2,1
    35b2:	fef40593          	addi	a1,s0,-17
    35b6:	00000097          	auipc	ra,0x0
    35ba:	f46080e7          	jalr	-186(ra) # 34fc <write>
}
    35be:	60e2                	ld	ra,24(sp)
    35c0:	6442                	ld	s0,16(sp)
    35c2:	6105                	addi	sp,sp,32
    35c4:	8082                	ret

00000000000035c6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    35c6:	7139                	addi	sp,sp,-64
    35c8:	fc06                	sd	ra,56(sp)
    35ca:	f822                	sd	s0,48(sp)
    35cc:	f426                	sd	s1,40(sp)
    35ce:	f04a                	sd	s2,32(sp)
    35d0:	ec4e                	sd	s3,24(sp)
    35d2:	0080                	addi	s0,sp,64
    35d4:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    35d6:	c299                	beqz	a3,35dc <printint+0x16>
    35d8:	0805c863          	bltz	a1,3668 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    35dc:	2581                	sext.w	a1,a1
  neg = 0;
    35de:	4881                	li	a7,0
    35e0:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    35e4:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    35e6:	2601                	sext.w	a2,a2
    35e8:	00000517          	auipc	a0,0x0
    35ec:	51050513          	addi	a0,a0,1296 # 3af8 <digits>
    35f0:	883a                	mv	a6,a4
    35f2:	2705                	addiw	a4,a4,1
    35f4:	02c5f7bb          	remuw	a5,a1,a2
    35f8:	1782                	slli	a5,a5,0x20
    35fa:	9381                	srli	a5,a5,0x20
    35fc:	97aa                	add	a5,a5,a0
    35fe:	0007c783          	lbu	a5,0(a5)
    3602:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    3606:	0005879b          	sext.w	a5,a1
    360a:	02c5d5bb          	divuw	a1,a1,a2
    360e:	0685                	addi	a3,a3,1
    3610:	fec7f0e3          	bgeu	a5,a2,35f0 <printint+0x2a>
  if(neg)
    3614:	00088b63          	beqz	a7,362a <printint+0x64>
    buf[i++] = '-';
    3618:	fd040793          	addi	a5,s0,-48
    361c:	973e                	add	a4,a4,a5
    361e:	02d00793          	li	a5,45
    3622:	fef70823          	sb	a5,-16(a4)
    3626:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    362a:	02e05863          	blez	a4,365a <printint+0x94>
    362e:	fc040793          	addi	a5,s0,-64
    3632:	00e78933          	add	s2,a5,a4
    3636:	fff78993          	addi	s3,a5,-1
    363a:	99ba                	add	s3,s3,a4
    363c:	377d                	addiw	a4,a4,-1
    363e:	1702                	slli	a4,a4,0x20
    3640:	9301                	srli	a4,a4,0x20
    3642:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    3646:	fff94583          	lbu	a1,-1(s2)
    364a:	8526                	mv	a0,s1
    364c:	00000097          	auipc	ra,0x0
    3650:	f58080e7          	jalr	-168(ra) # 35a4 <putc>
  while(--i >= 0)
    3654:	197d                	addi	s2,s2,-1
    3656:	ff3918e3          	bne	s2,s3,3646 <printint+0x80>
}
    365a:	70e2                	ld	ra,56(sp)
    365c:	7442                	ld	s0,48(sp)
    365e:	74a2                	ld	s1,40(sp)
    3660:	7902                	ld	s2,32(sp)
    3662:	69e2                	ld	s3,24(sp)
    3664:	6121                	addi	sp,sp,64
    3666:	8082                	ret
    x = -xx;
    3668:	40b005bb          	negw	a1,a1
    neg = 1;
    366c:	4885                	li	a7,1
    x = -xx;
    366e:	bf8d                	j	35e0 <printint+0x1a>

0000000000003670 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    3670:	7119                	addi	sp,sp,-128
    3672:	fc86                	sd	ra,120(sp)
    3674:	f8a2                	sd	s0,112(sp)
    3676:	f4a6                	sd	s1,104(sp)
    3678:	f0ca                	sd	s2,96(sp)
    367a:	ecce                	sd	s3,88(sp)
    367c:	e8d2                	sd	s4,80(sp)
    367e:	e4d6                	sd	s5,72(sp)
    3680:	e0da                	sd	s6,64(sp)
    3682:	fc5e                	sd	s7,56(sp)
    3684:	f862                	sd	s8,48(sp)
    3686:	f466                	sd	s9,40(sp)
    3688:	f06a                	sd	s10,32(sp)
    368a:	ec6e                	sd	s11,24(sp)
    368c:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    368e:	0005c903          	lbu	s2,0(a1)
    3692:	18090f63          	beqz	s2,3830 <vprintf+0x1c0>
    3696:	8aaa                	mv	s5,a0
    3698:	8b32                	mv	s6,a2
    369a:	00158493          	addi	s1,a1,1
  state = 0;
    369e:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    36a0:	02500a13          	li	s4,37
      if(c == 'd'){
    36a4:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    36a8:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    36ac:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    36b0:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    36b4:	00000b97          	auipc	s7,0x0
    36b8:	444b8b93          	addi	s7,s7,1092 # 3af8 <digits>
    36bc:	a839                	j	36da <vprintf+0x6a>
        putc(fd, c);
    36be:	85ca                	mv	a1,s2
    36c0:	8556                	mv	a0,s5
    36c2:	00000097          	auipc	ra,0x0
    36c6:	ee2080e7          	jalr	-286(ra) # 35a4 <putc>
    36ca:	a019                	j	36d0 <vprintf+0x60>
    } else if(state == '%'){
    36cc:	01498f63          	beq	s3,s4,36ea <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    36d0:	0485                	addi	s1,s1,1
    36d2:	fff4c903          	lbu	s2,-1(s1)
    36d6:	14090d63          	beqz	s2,3830 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    36da:	0009079b          	sext.w	a5,s2
    if(state == 0){
    36de:	fe0997e3          	bnez	s3,36cc <vprintf+0x5c>
      if(c == '%'){
    36e2:	fd479ee3          	bne	a5,s4,36be <vprintf+0x4e>
        state = '%';
    36e6:	89be                	mv	s3,a5
    36e8:	b7e5                	j	36d0 <vprintf+0x60>
      if(c == 'd'){
    36ea:	05878063          	beq	a5,s8,372a <vprintf+0xba>
      } else if(c == 'l') {
    36ee:	05978c63          	beq	a5,s9,3746 <vprintf+0xd6>
      } else if(c == 'x') {
    36f2:	07a78863          	beq	a5,s10,3762 <vprintf+0xf2>
      } else if(c == 'p') {
    36f6:	09b78463          	beq	a5,s11,377e <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    36fa:	07300713          	li	a4,115
    36fe:	0ce78663          	beq	a5,a4,37ca <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3702:	06300713          	li	a4,99
    3706:	0ee78e63          	beq	a5,a4,3802 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    370a:	11478863          	beq	a5,s4,381a <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    370e:	85d2                	mv	a1,s4
    3710:	8556                	mv	a0,s5
    3712:	00000097          	auipc	ra,0x0
    3716:	e92080e7          	jalr	-366(ra) # 35a4 <putc>
        putc(fd, c);
    371a:	85ca                	mv	a1,s2
    371c:	8556                	mv	a0,s5
    371e:	00000097          	auipc	ra,0x0
    3722:	e86080e7          	jalr	-378(ra) # 35a4 <putc>
      }
      state = 0;
    3726:	4981                	li	s3,0
    3728:	b765                	j	36d0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    372a:	008b0913          	addi	s2,s6,8
    372e:	4685                	li	a3,1
    3730:	4629                	li	a2,10
    3732:	000b2583          	lw	a1,0(s6)
    3736:	8556                	mv	a0,s5
    3738:	00000097          	auipc	ra,0x0
    373c:	e8e080e7          	jalr	-370(ra) # 35c6 <printint>
    3740:	8b4a                	mv	s6,s2
      state = 0;
    3742:	4981                	li	s3,0
    3744:	b771                	j	36d0 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    3746:	008b0913          	addi	s2,s6,8
    374a:	4681                	li	a3,0
    374c:	4629                	li	a2,10
    374e:	000b2583          	lw	a1,0(s6)
    3752:	8556                	mv	a0,s5
    3754:	00000097          	auipc	ra,0x0
    3758:	e72080e7          	jalr	-398(ra) # 35c6 <printint>
    375c:	8b4a                	mv	s6,s2
      state = 0;
    375e:	4981                	li	s3,0
    3760:	bf85                	j	36d0 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    3762:	008b0913          	addi	s2,s6,8
    3766:	4681                	li	a3,0
    3768:	4641                	li	a2,16
    376a:	000b2583          	lw	a1,0(s6)
    376e:	8556                	mv	a0,s5
    3770:	00000097          	auipc	ra,0x0
    3774:	e56080e7          	jalr	-426(ra) # 35c6 <printint>
    3778:	8b4a                	mv	s6,s2
      state = 0;
    377a:	4981                	li	s3,0
    377c:	bf91                	j	36d0 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    377e:	008b0793          	addi	a5,s6,8
    3782:	f8f43423          	sd	a5,-120(s0)
    3786:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    378a:	03000593          	li	a1,48
    378e:	8556                	mv	a0,s5
    3790:	00000097          	auipc	ra,0x0
    3794:	e14080e7          	jalr	-492(ra) # 35a4 <putc>
  putc(fd, 'x');
    3798:	85ea                	mv	a1,s10
    379a:	8556                	mv	a0,s5
    379c:	00000097          	auipc	ra,0x0
    37a0:	e08080e7          	jalr	-504(ra) # 35a4 <putc>
    37a4:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    37a6:	03c9d793          	srli	a5,s3,0x3c
    37aa:	97de                	add	a5,a5,s7
    37ac:	0007c583          	lbu	a1,0(a5)
    37b0:	8556                	mv	a0,s5
    37b2:	00000097          	auipc	ra,0x0
    37b6:	df2080e7          	jalr	-526(ra) # 35a4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    37ba:	0992                	slli	s3,s3,0x4
    37bc:	397d                	addiw	s2,s2,-1
    37be:	fe0914e3          	bnez	s2,37a6 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    37c2:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    37c6:	4981                	li	s3,0
    37c8:	b721                	j	36d0 <vprintf+0x60>
        s = va_arg(ap, char*);
    37ca:	008b0993          	addi	s3,s6,8
    37ce:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    37d2:	02090163          	beqz	s2,37f4 <vprintf+0x184>
        while(*s != 0){
    37d6:	00094583          	lbu	a1,0(s2)
    37da:	c9a1                	beqz	a1,382a <vprintf+0x1ba>
          putc(fd, *s);
    37dc:	8556                	mv	a0,s5
    37de:	00000097          	auipc	ra,0x0
    37e2:	dc6080e7          	jalr	-570(ra) # 35a4 <putc>
          s++;
    37e6:	0905                	addi	s2,s2,1
        while(*s != 0){
    37e8:	00094583          	lbu	a1,0(s2)
    37ec:	f9e5                	bnez	a1,37dc <vprintf+0x16c>
        s = va_arg(ap, char*);
    37ee:	8b4e                	mv	s6,s3
      state = 0;
    37f0:	4981                	li	s3,0
    37f2:	bdf9                	j	36d0 <vprintf+0x60>
          s = "(null)";
    37f4:	00000917          	auipc	s2,0x0
    37f8:	2fc90913          	addi	s2,s2,764 # 3af0 <malloc+0x1b6>
        while(*s != 0){
    37fc:	02800593          	li	a1,40
    3800:	bff1                	j	37dc <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    3802:	008b0913          	addi	s2,s6,8
    3806:	000b4583          	lbu	a1,0(s6)
    380a:	8556                	mv	a0,s5
    380c:	00000097          	auipc	ra,0x0
    3810:	d98080e7          	jalr	-616(ra) # 35a4 <putc>
    3814:	8b4a                	mv	s6,s2
      state = 0;
    3816:	4981                	li	s3,0
    3818:	bd65                	j	36d0 <vprintf+0x60>
        putc(fd, c);
    381a:	85d2                	mv	a1,s4
    381c:	8556                	mv	a0,s5
    381e:	00000097          	auipc	ra,0x0
    3822:	d86080e7          	jalr	-634(ra) # 35a4 <putc>
      state = 0;
    3826:	4981                	li	s3,0
    3828:	b565                	j	36d0 <vprintf+0x60>
        s = va_arg(ap, char*);
    382a:	8b4e                	mv	s6,s3
      state = 0;
    382c:	4981                	li	s3,0
    382e:	b54d                	j	36d0 <vprintf+0x60>
    }
  }
}
    3830:	70e6                	ld	ra,120(sp)
    3832:	7446                	ld	s0,112(sp)
    3834:	74a6                	ld	s1,104(sp)
    3836:	7906                	ld	s2,96(sp)
    3838:	69e6                	ld	s3,88(sp)
    383a:	6a46                	ld	s4,80(sp)
    383c:	6aa6                	ld	s5,72(sp)
    383e:	6b06                	ld	s6,64(sp)
    3840:	7be2                	ld	s7,56(sp)
    3842:	7c42                	ld	s8,48(sp)
    3844:	7ca2                	ld	s9,40(sp)
    3846:	7d02                	ld	s10,32(sp)
    3848:	6de2                	ld	s11,24(sp)
    384a:	6109                	addi	sp,sp,128
    384c:	8082                	ret

000000000000384e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    384e:	715d                	addi	sp,sp,-80
    3850:	ec06                	sd	ra,24(sp)
    3852:	e822                	sd	s0,16(sp)
    3854:	1000                	addi	s0,sp,32
    3856:	e010                	sd	a2,0(s0)
    3858:	e414                	sd	a3,8(s0)
    385a:	e818                	sd	a4,16(s0)
    385c:	ec1c                	sd	a5,24(s0)
    385e:	03043023          	sd	a6,32(s0)
    3862:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    3866:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    386a:	8622                	mv	a2,s0
    386c:	00000097          	auipc	ra,0x0
    3870:	e04080e7          	jalr	-508(ra) # 3670 <vprintf>
}
    3874:	60e2                	ld	ra,24(sp)
    3876:	6442                	ld	s0,16(sp)
    3878:	6161                	addi	sp,sp,80
    387a:	8082                	ret

000000000000387c <printf>:

void
printf(const char *fmt, ...)
{
    387c:	711d                	addi	sp,sp,-96
    387e:	ec06                	sd	ra,24(sp)
    3880:	e822                	sd	s0,16(sp)
    3882:	1000                	addi	s0,sp,32
    3884:	e40c                	sd	a1,8(s0)
    3886:	e810                	sd	a2,16(s0)
    3888:	ec14                	sd	a3,24(s0)
    388a:	f018                	sd	a4,32(s0)
    388c:	f41c                	sd	a5,40(s0)
    388e:	03043823          	sd	a6,48(s0)
    3892:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    3896:	00840613          	addi	a2,s0,8
    389a:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    389e:	85aa                	mv	a1,a0
    38a0:	4505                	li	a0,1
    38a2:	00000097          	auipc	ra,0x0
    38a6:	dce080e7          	jalr	-562(ra) # 3670 <vprintf>
}
    38aa:	60e2                	ld	ra,24(sp)
    38ac:	6442                	ld	s0,16(sp)
    38ae:	6125                	addi	sp,sp,96
    38b0:	8082                	ret

00000000000038b2 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    38b2:	1141                	addi	sp,sp,-16
    38b4:	e422                	sd	s0,8(sp)
    38b6:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    38b8:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    38bc:	00000797          	auipc	a5,0x0
    38c0:	7447b783          	ld	a5,1860(a5) # 4000 <freep>
    38c4:	a805                	j	38f4 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    38c6:	4618                	lw	a4,8(a2)
    38c8:	9db9                	addw	a1,a1,a4
    38ca:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    38ce:	6398                	ld	a4,0(a5)
    38d0:	6318                	ld	a4,0(a4)
    38d2:	fee53823          	sd	a4,-16(a0)
    38d6:	a091                	j	391a <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    38d8:	ff852703          	lw	a4,-8(a0)
    38dc:	9e39                	addw	a2,a2,a4
    38de:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    38e0:	ff053703          	ld	a4,-16(a0)
    38e4:	e398                	sd	a4,0(a5)
    38e6:	a099                	j	392c <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    38e8:	6398                	ld	a4,0(a5)
    38ea:	00e7e463          	bltu	a5,a4,38f2 <free+0x40>
    38ee:	00e6ea63          	bltu	a3,a4,3902 <free+0x50>
{
    38f2:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    38f4:	fed7fae3          	bgeu	a5,a3,38e8 <free+0x36>
    38f8:	6398                	ld	a4,0(a5)
    38fa:	00e6e463          	bltu	a3,a4,3902 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    38fe:	fee7eae3          	bltu	a5,a4,38f2 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    3902:	ff852583          	lw	a1,-8(a0)
    3906:	6390                	ld	a2,0(a5)
    3908:	02059713          	slli	a4,a1,0x20
    390c:	9301                	srli	a4,a4,0x20
    390e:	0712                	slli	a4,a4,0x4
    3910:	9736                	add	a4,a4,a3
    3912:	fae60ae3          	beq	a2,a4,38c6 <free+0x14>
    bp->s.ptr = p->s.ptr;
    3916:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    391a:	4790                	lw	a2,8(a5)
    391c:	02061713          	slli	a4,a2,0x20
    3920:	9301                	srli	a4,a4,0x20
    3922:	0712                	slli	a4,a4,0x4
    3924:	973e                	add	a4,a4,a5
    3926:	fae689e3          	beq	a3,a4,38d8 <free+0x26>
  } else
    p->s.ptr = bp;
    392a:	e394                	sd	a3,0(a5)
  freep = p;
    392c:	00000717          	auipc	a4,0x0
    3930:	6cf73a23          	sd	a5,1748(a4) # 4000 <freep>
}
    3934:	6422                	ld	s0,8(sp)
    3936:	0141                	addi	sp,sp,16
    3938:	8082                	ret

000000000000393a <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    393a:	7139                	addi	sp,sp,-64
    393c:	fc06                	sd	ra,56(sp)
    393e:	f822                	sd	s0,48(sp)
    3940:	f426                	sd	s1,40(sp)
    3942:	f04a                	sd	s2,32(sp)
    3944:	ec4e                	sd	s3,24(sp)
    3946:	e852                	sd	s4,16(sp)
    3948:	e456                	sd	s5,8(sp)
    394a:	e05a                	sd	s6,0(sp)
    394c:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    394e:	02051493          	slli	s1,a0,0x20
    3952:	9081                	srli	s1,s1,0x20
    3954:	04bd                	addi	s1,s1,15
    3956:	8091                	srli	s1,s1,0x4
    3958:	0014899b          	addiw	s3,s1,1
    395c:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    395e:	00000517          	auipc	a0,0x0
    3962:	6a253503          	ld	a0,1698(a0) # 4000 <freep>
    3966:	c515                	beqz	a0,3992 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3968:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    396a:	4798                	lw	a4,8(a5)
    396c:	02977f63          	bgeu	a4,s1,39aa <malloc+0x70>
    3970:	8a4e                	mv	s4,s3
    3972:	0009871b          	sext.w	a4,s3
    3976:	6685                	lui	a3,0x1
    3978:	00d77363          	bgeu	a4,a3,397e <malloc+0x44>
    397c:	6a05                	lui	s4,0x1
    397e:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    3982:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3986:	00000917          	auipc	s2,0x0
    398a:	67a90913          	addi	s2,s2,1658 # 4000 <freep>
  if(p == (char*)-1)
    398e:	5afd                	li	s5,-1
    3990:	a88d                	j	3a02 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    3992:	00000797          	auipc	a5,0x0
    3996:	67e78793          	addi	a5,a5,1662 # 4010 <base>
    399a:	00000717          	auipc	a4,0x0
    399e:	66f73323          	sd	a5,1638(a4) # 4000 <freep>
    39a2:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    39a4:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    39a8:	b7e1                	j	3970 <malloc+0x36>
      if(p->s.size == nunits)
    39aa:	02e48b63          	beq	s1,a4,39e0 <malloc+0xa6>
        p->s.size -= nunits;
    39ae:	4137073b          	subw	a4,a4,s3
    39b2:	c798                	sw	a4,8(a5)
        p += p->s.size;
    39b4:	1702                	slli	a4,a4,0x20
    39b6:	9301                	srli	a4,a4,0x20
    39b8:	0712                	slli	a4,a4,0x4
    39ba:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    39bc:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    39c0:	00000717          	auipc	a4,0x0
    39c4:	64a73023          	sd	a0,1600(a4) # 4000 <freep>
      return (void*)(p + 1);
    39c8:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    39cc:	70e2                	ld	ra,56(sp)
    39ce:	7442                	ld	s0,48(sp)
    39d0:	74a2                	ld	s1,40(sp)
    39d2:	7902                	ld	s2,32(sp)
    39d4:	69e2                	ld	s3,24(sp)
    39d6:	6a42                	ld	s4,16(sp)
    39d8:	6aa2                	ld	s5,8(sp)
    39da:	6b02                	ld	s6,0(sp)
    39dc:	6121                	addi	sp,sp,64
    39de:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    39e0:	6398                	ld	a4,0(a5)
    39e2:	e118                	sd	a4,0(a0)
    39e4:	bff1                	j	39c0 <malloc+0x86>
  hp->s.size = nu;
    39e6:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    39ea:	0541                	addi	a0,a0,16
    39ec:	00000097          	auipc	ra,0x0
    39f0:	ec6080e7          	jalr	-314(ra) # 38b2 <free>
  return freep;
    39f4:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    39f8:	d971                	beqz	a0,39cc <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    39fa:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    39fc:	4798                	lw	a4,8(a5)
    39fe:	fa9776e3          	bgeu	a4,s1,39aa <malloc+0x70>
    if(p == freep)
    3a02:	00093703          	ld	a4,0(s2)
    3a06:	853e                	mv	a0,a5
    3a08:	fef719e3          	bne	a4,a5,39fa <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3a0c:	8552                	mv	a0,s4
    3a0e:	00000097          	auipc	ra,0x0
    3a12:	b56080e7          	jalr	-1194(ra) # 3564 <sbrk>
  if(p == (char*)-1)
    3a16:	fd5518e3          	bne	a0,s5,39e6 <malloc+0xac>
        return 0;
    3a1a:	4501                	li	a0,0
    3a1c:	bf45                	j	39cc <malloc+0x92>
