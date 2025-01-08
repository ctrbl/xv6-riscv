
user/_uniq_k:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

#define BUF_SIZE  512

int main(int argc, char *argv[]) {
    3000:	dc010113          	addi	sp,sp,-576
    3004:	22113c23          	sd	ra,568(sp)
    3008:	22813823          	sd	s0,560(sp)
    300c:	22913423          	sd	s1,552(sp)
    3010:	23213023          	sd	s2,544(sp)
    3014:	21313c23          	sd	s3,536(sp)
    3018:	21413823          	sd	s4,528(sp)
    301c:	21513423          	sd	s5,520(sp)
    3020:	0480                	addi	s0,sp,576
    3022:	84aa                	mv	s1,a0
    3024:	892e                	mv	s2,a1
  int fd, c_flag = 0, d_flag = 0, i_flag = 0; 
  char buf[BUF_SIZE];     
  printf("Uniq command is getting executed in user mode.\n");
    3026:	00001517          	auipc	a0,0x1
    302a:	94a50513          	addi	a0,a0,-1718 # 3970 <malloc+0xee>
    302e:	00000097          	auipc	ra,0x0
    3032:	796080e7          	jalr	1942(ra) # 37c4 <printf>

  // Read from standard input
  if (argc <= 1) {
    3036:	4785                	li	a5,1
    3038:	0297d963          	bge	a5,s1,306a <main+0x6a>
    303c:	00890893          	addi	a7,s2,8
    3040:	ffe4881b          	addiw	a6,s1,-2
    3044:	1802                	slli	a6,a6,0x20
    3046:	02085813          	srli	a6,a6,0x20
    304a:	080e                	slli	a6,a6,0x3
    304c:	0941                	addi	s2,s2,16
    304e:	984a                	add	a6,a6,s2
  int fd, c_flag = 0, d_flag = 0, i_flag = 0; 
    3050:	4481                	li	s1,0
    3052:	4981                	li	s3,0
    3054:	4901                	li	s2,0

  int i, j;
  // Process flags and text file in format (allow only 1 file with multi flags)
  // uniq [-c | -d | -i] filename.extension
  for (i = 1; i < argc; i++) {
    if (argv[i][0] == '-') {
    3056:	02d00313          	li	t1,45
      for (j = 1; argv[i][j] != '\0'; j++) {
        if (argv[i][j] == 'c') 
    305a:	06300793          	li	a5,99
          c_flag = 1;
    305e:	4705                	li	a4,1
        else if (argv[i][j] == 'd')
    3060:	06400693          	li	a3,100
          d_flag = 1;
        else if (argv[i][j] == 'i')
    3064:	06900613          	li	a2,105
    3068:	a84d                	j	311a <main+0x11a>
    uniq_k(0, (uint64)buf, c_flag, d_flag, i_flag); 
    306a:	4701                	li	a4,0
    306c:	4681                	li	a3,0
    306e:	4601                	li	a2,0
    3070:	dc040593          	addi	a1,s0,-576
    3074:	4501                	li	a0,0
    3076:	00000097          	auipc	ra,0x0
    307a:	44e080e7          	jalr	1102(ra) # 34c4 <uniq_k>
    exit(0); 
    307e:	4501                	li	a0,0
    3080:	00000097          	auipc	ra,0x0
    3084:	39c080e7          	jalr	924(ra) # 341c <exit>
          i_flag = 1; 
        else {
          printf("uniq: invalid option -%c\n", argv[i][j]); 
    3088:	00001517          	auipc	a0,0x1
    308c:	91850513          	addi	a0,a0,-1768 # 39a0 <malloc+0x11e>
    3090:	00000097          	auipc	ra,0x0
    3094:	734080e7          	jalr	1844(ra) # 37c4 <printf>
          exit(1);
    3098:	4505                	li	a0,1
    309a:	00000097          	auipc	ra,0x0
    309e:	382080e7          	jalr	898(ra) # 341c <exit>
          c_flag = 1;
    30a2:	893a                	mv	s2,a4
      for (j = 1; argv[i][j] != '\0'; j++) {
    30a4:	0505                	addi	a0,a0,1
    30a6:	fff54583          	lbu	a1,-1(a0)
    30aa:	c5ad                	beqz	a1,3114 <main+0x114>
        if (argv[i][j] == 'c') 
    30ac:	fef58be3          	beq	a1,a5,30a2 <main+0xa2>
        else if (argv[i][j] == 'd')
    30b0:	00d58663          	beq	a1,a3,30bc <main+0xbc>
        else if (argv[i][j] == 'i')
    30b4:	fcc59ae3          	bne	a1,a2,3088 <main+0x88>
          i_flag = 1; 
    30b8:	84ba                	mv	s1,a4
    30ba:	b7ed                	j	30a4 <main+0xa4>
          d_flag = 1;
    30bc:	89ba                	mv	s3,a4
    30be:	b7dd                	j	30a4 <main+0xa4>
        }
      }
    } else {
      if ((fd = open(argv[i], 0)) < 0) {
    30c0:	4581                	li	a1,0
    30c2:	00000097          	auipc	ra,0x0
    30c6:	3a2080e7          	jalr	930(ra) # 3464 <open>
    30ca:	8aaa                	mv	s5,a0
    30cc:	02054563          	bltz	a0,30f6 <main+0xf6>
        printf("uniq: cannot open %s\n", argv[i]); 
	      exit(1);
      }
      uniq_k(fd, (uint64)buf, c_flag, d_flag, i_flag); 
    30d0:	8726                	mv	a4,s1
    30d2:	86ce                	mv	a3,s3
    30d4:	864a                	mv	a2,s2
    30d6:	dc040593          	addi	a1,s0,-576
    30da:	00000097          	auipc	ra,0x0
    30de:	3ea080e7          	jalr	1002(ra) # 34c4 <uniq_k>
      close(fd);
    30e2:	8556                	mv	a0,s5
    30e4:	00000097          	auipc	ra,0x0
    30e8:	368080e7          	jalr	872(ra) # 344c <close>
      exit(0);  
    30ec:	4501                	li	a0,0
    30ee:	00000097          	auipc	ra,0x0
    30f2:	32e080e7          	jalr	814(ra) # 341c <exit>
        printf("uniq: cannot open %s\n", argv[i]); 
    30f6:	000a3583          	ld	a1,0(s4)
    30fa:	00001517          	auipc	a0,0x1
    30fe:	8c650513          	addi	a0,a0,-1850 # 39c0 <malloc+0x13e>
    3102:	00000097          	auipc	ra,0x0
    3106:	6c2080e7          	jalr	1730(ra) # 37c4 <printf>
	      exit(1);
    310a:	4505                	li	a0,1
    310c:	00000097          	auipc	ra,0x0
    3110:	310080e7          	jalr	784(ra) # 341c <exit>
  for (i = 1; i < argc; i++) {
    3114:	08a1                	addi	a7,a7,8
    3116:	01088e63          	beq	a7,a6,3132 <main+0x132>
    if (argv[i][0] == '-') {
    311a:	8a46                	mv	s4,a7
    311c:	0008b503          	ld	a0,0(a7)
    3120:	00054583          	lbu	a1,0(a0)
    3124:	f8659ee3          	bne	a1,t1,30c0 <main+0xc0>
      for (j = 1; argv[i][j] != '\0'; j++) {
    3128:	00154583          	lbu	a1,1(a0)
    312c:	d5e5                	beqz	a1,3114 <main+0x114>
    312e:	0509                	addi	a0,a0,2
    3130:	bfb5                	j	30ac <main+0xac>
    }
  }
  exit(0); 
    3132:	4501                	li	a0,0
    3134:	00000097          	auipc	ra,0x0
    3138:	2e8080e7          	jalr	744(ra) # 341c <exit>

000000000000313c <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    313c:	1141                	addi	sp,sp,-16
    313e:	e406                	sd	ra,8(sp)
    3140:	e022                	sd	s0,0(sp)
    3142:	0800                	addi	s0,sp,16
  extern int main();
  main();
    3144:	00000097          	auipc	ra,0x0
    3148:	ebc080e7          	jalr	-324(ra) # 3000 <main>
  exit(0);
    314c:	4501                	li	a0,0
    314e:	00000097          	auipc	ra,0x0
    3152:	2ce080e7          	jalr	718(ra) # 341c <exit>

0000000000003156 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    3156:	1141                	addi	sp,sp,-16
    3158:	e422                	sd	s0,8(sp)
    315a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    315c:	87aa                	mv	a5,a0
    315e:	0585                	addi	a1,a1,1
    3160:	0785                	addi	a5,a5,1
    3162:	fff5c703          	lbu	a4,-1(a1)
    3166:	fee78fa3          	sb	a4,-1(a5)
    316a:	fb75                	bnez	a4,315e <strcpy+0x8>
    ;
  return os;
}
    316c:	6422                	ld	s0,8(sp)
    316e:	0141                	addi	sp,sp,16
    3170:	8082                	ret

0000000000003172 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3172:	1141                	addi	sp,sp,-16
    3174:	e422                	sd	s0,8(sp)
    3176:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    3178:	00054783          	lbu	a5,0(a0)
    317c:	cb91                	beqz	a5,3190 <strcmp+0x1e>
    317e:	0005c703          	lbu	a4,0(a1)
    3182:	00f71763          	bne	a4,a5,3190 <strcmp+0x1e>
    p++, q++;
    3186:	0505                	addi	a0,a0,1
    3188:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    318a:	00054783          	lbu	a5,0(a0)
    318e:	fbe5                	bnez	a5,317e <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    3190:	0005c503          	lbu	a0,0(a1)
}
    3194:	40a7853b          	subw	a0,a5,a0
    3198:	6422                	ld	s0,8(sp)
    319a:	0141                	addi	sp,sp,16
    319c:	8082                	ret

000000000000319e <strlen>:

uint
strlen(const char *s)
{
    319e:	1141                	addi	sp,sp,-16
    31a0:	e422                	sd	s0,8(sp)
    31a2:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    31a4:	00054783          	lbu	a5,0(a0)
    31a8:	cf91                	beqz	a5,31c4 <strlen+0x26>
    31aa:	0505                	addi	a0,a0,1
    31ac:	87aa                	mv	a5,a0
    31ae:	4685                	li	a3,1
    31b0:	9e89                	subw	a3,a3,a0
    31b2:	00f6853b          	addw	a0,a3,a5
    31b6:	0785                	addi	a5,a5,1
    31b8:	fff7c703          	lbu	a4,-1(a5)
    31bc:	fb7d                	bnez	a4,31b2 <strlen+0x14>
    ;
  return n;
}
    31be:	6422                	ld	s0,8(sp)
    31c0:	0141                	addi	sp,sp,16
    31c2:	8082                	ret
  for(n = 0; s[n]; n++)
    31c4:	4501                	li	a0,0
    31c6:	bfe5                	j	31be <strlen+0x20>

00000000000031c8 <memset>:

void*
memset(void *dst, int c, uint n)
{
    31c8:	1141                	addi	sp,sp,-16
    31ca:	e422                	sd	s0,8(sp)
    31cc:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    31ce:	ca19                	beqz	a2,31e4 <memset+0x1c>
    31d0:	87aa                	mv	a5,a0
    31d2:	1602                	slli	a2,a2,0x20
    31d4:	9201                	srli	a2,a2,0x20
    31d6:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    31da:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    31de:	0785                	addi	a5,a5,1
    31e0:	fee79de3          	bne	a5,a4,31da <memset+0x12>
  }
  return dst;
}
    31e4:	6422                	ld	s0,8(sp)
    31e6:	0141                	addi	sp,sp,16
    31e8:	8082                	ret

00000000000031ea <strchr>:

char*
strchr(const char *s, char c)
{
    31ea:	1141                	addi	sp,sp,-16
    31ec:	e422                	sd	s0,8(sp)
    31ee:	0800                	addi	s0,sp,16
  for(; *s; s++)
    31f0:	00054783          	lbu	a5,0(a0)
    31f4:	cb99                	beqz	a5,320a <strchr+0x20>
    if(*s == c)
    31f6:	00f58763          	beq	a1,a5,3204 <strchr+0x1a>
  for(; *s; s++)
    31fa:	0505                	addi	a0,a0,1
    31fc:	00054783          	lbu	a5,0(a0)
    3200:	fbfd                	bnez	a5,31f6 <strchr+0xc>
      return (char*)s;
  return 0;
    3202:	4501                	li	a0,0
}
    3204:	6422                	ld	s0,8(sp)
    3206:	0141                	addi	sp,sp,16
    3208:	8082                	ret
  return 0;
    320a:	4501                	li	a0,0
    320c:	bfe5                	j	3204 <strchr+0x1a>

000000000000320e <gets>:

char*
gets(char *buf, int max)
{
    320e:	711d                	addi	sp,sp,-96
    3210:	ec86                	sd	ra,88(sp)
    3212:	e8a2                	sd	s0,80(sp)
    3214:	e4a6                	sd	s1,72(sp)
    3216:	e0ca                	sd	s2,64(sp)
    3218:	fc4e                	sd	s3,56(sp)
    321a:	f852                	sd	s4,48(sp)
    321c:	f456                	sd	s5,40(sp)
    321e:	f05a                	sd	s6,32(sp)
    3220:	ec5e                	sd	s7,24(sp)
    3222:	1080                	addi	s0,sp,96
    3224:	8baa                	mv	s7,a0
    3226:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3228:	892a                	mv	s2,a0
    322a:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    322c:	4aa9                	li	s5,10
    322e:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    3230:	89a6                	mv	s3,s1
    3232:	2485                	addiw	s1,s1,1
    3234:	0344d863          	bge	s1,s4,3264 <gets+0x56>
    cc = read(0, &c, 1);
    3238:	4605                	li	a2,1
    323a:	faf40593          	addi	a1,s0,-81
    323e:	4501                	li	a0,0
    3240:	00000097          	auipc	ra,0x0
    3244:	1fc080e7          	jalr	508(ra) # 343c <read>
    if(cc < 1)
    3248:	00a05e63          	blez	a0,3264 <gets+0x56>
    buf[i++] = c;
    324c:	faf44783          	lbu	a5,-81(s0)
    3250:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    3254:	01578763          	beq	a5,s5,3262 <gets+0x54>
    3258:	0905                	addi	s2,s2,1
    325a:	fd679be3          	bne	a5,s6,3230 <gets+0x22>
  for(i=0; i+1 < max; ){
    325e:	89a6                	mv	s3,s1
    3260:	a011                	j	3264 <gets+0x56>
    3262:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    3264:	99de                	add	s3,s3,s7
    3266:	00098023          	sb	zero,0(s3)
  return buf;
}
    326a:	855e                	mv	a0,s7
    326c:	60e6                	ld	ra,88(sp)
    326e:	6446                	ld	s0,80(sp)
    3270:	64a6                	ld	s1,72(sp)
    3272:	6906                	ld	s2,64(sp)
    3274:	79e2                	ld	s3,56(sp)
    3276:	7a42                	ld	s4,48(sp)
    3278:	7aa2                	ld	s5,40(sp)
    327a:	7b02                	ld	s6,32(sp)
    327c:	6be2                	ld	s7,24(sp)
    327e:	6125                	addi	sp,sp,96
    3280:	8082                	ret

0000000000003282 <stat>:

int
stat(const char *n, struct stat *st)
{
    3282:	1101                	addi	sp,sp,-32
    3284:	ec06                	sd	ra,24(sp)
    3286:	e822                	sd	s0,16(sp)
    3288:	e426                	sd	s1,8(sp)
    328a:	e04a                	sd	s2,0(sp)
    328c:	1000                	addi	s0,sp,32
    328e:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3290:	4581                	li	a1,0
    3292:	00000097          	auipc	ra,0x0
    3296:	1d2080e7          	jalr	466(ra) # 3464 <open>
  if(fd < 0)
    329a:	02054563          	bltz	a0,32c4 <stat+0x42>
    329e:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    32a0:	85ca                	mv	a1,s2
    32a2:	00000097          	auipc	ra,0x0
    32a6:	1da080e7          	jalr	474(ra) # 347c <fstat>
    32aa:	892a                	mv	s2,a0
  close(fd);
    32ac:	8526                	mv	a0,s1
    32ae:	00000097          	auipc	ra,0x0
    32b2:	19e080e7          	jalr	414(ra) # 344c <close>
  return r;
}
    32b6:	854a                	mv	a0,s2
    32b8:	60e2                	ld	ra,24(sp)
    32ba:	6442                	ld	s0,16(sp)
    32bc:	64a2                	ld	s1,8(sp)
    32be:	6902                	ld	s2,0(sp)
    32c0:	6105                	addi	sp,sp,32
    32c2:	8082                	ret
    return -1;
    32c4:	597d                	li	s2,-1
    32c6:	bfc5                	j	32b6 <stat+0x34>

00000000000032c8 <atoi>:

int
atoi(const char *s)
{
    32c8:	1141                	addi	sp,sp,-16
    32ca:	e422                	sd	s0,8(sp)
    32cc:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    32ce:	00054603          	lbu	a2,0(a0)
    32d2:	fd06079b          	addiw	a5,a2,-48
    32d6:	0ff7f793          	andi	a5,a5,255
    32da:	4725                	li	a4,9
    32dc:	02f76963          	bltu	a4,a5,330e <atoi+0x46>
    32e0:	86aa                	mv	a3,a0
  n = 0;
    32e2:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    32e4:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    32e6:	0685                	addi	a3,a3,1
    32e8:	0025179b          	slliw	a5,a0,0x2
    32ec:	9fa9                	addw	a5,a5,a0
    32ee:	0017979b          	slliw	a5,a5,0x1
    32f2:	9fb1                	addw	a5,a5,a2
    32f4:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    32f8:	0006c603          	lbu	a2,0(a3)
    32fc:	fd06071b          	addiw	a4,a2,-48
    3300:	0ff77713          	andi	a4,a4,255
    3304:	fee5f1e3          	bgeu	a1,a4,32e6 <atoi+0x1e>
  return n;
}
    3308:	6422                	ld	s0,8(sp)
    330a:	0141                	addi	sp,sp,16
    330c:	8082                	ret
  n = 0;
    330e:	4501                	li	a0,0
    3310:	bfe5                	j	3308 <atoi+0x40>

0000000000003312 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3312:	1141                	addi	sp,sp,-16
    3314:	e422                	sd	s0,8(sp)
    3316:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    3318:	02b57463          	bgeu	a0,a1,3340 <memmove+0x2e>
    while(n-- > 0)
    331c:	00c05f63          	blez	a2,333a <memmove+0x28>
    3320:	1602                	slli	a2,a2,0x20
    3322:	9201                	srli	a2,a2,0x20
    3324:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    3328:	872a                	mv	a4,a0
      *dst++ = *src++;
    332a:	0585                	addi	a1,a1,1
    332c:	0705                	addi	a4,a4,1
    332e:	fff5c683          	lbu	a3,-1(a1)
    3332:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    3336:	fee79ae3          	bne	a5,a4,332a <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    333a:	6422                	ld	s0,8(sp)
    333c:	0141                	addi	sp,sp,16
    333e:	8082                	ret
    dst += n;
    3340:	00c50733          	add	a4,a0,a2
    src += n;
    3344:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    3346:	fec05ae3          	blez	a2,333a <memmove+0x28>
    334a:	fff6079b          	addiw	a5,a2,-1
    334e:	1782                	slli	a5,a5,0x20
    3350:	9381                	srli	a5,a5,0x20
    3352:	fff7c793          	not	a5,a5
    3356:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    3358:	15fd                	addi	a1,a1,-1
    335a:	177d                	addi	a4,a4,-1
    335c:	0005c683          	lbu	a3,0(a1)
    3360:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    3364:	fee79ae3          	bne	a5,a4,3358 <memmove+0x46>
    3368:	bfc9                	j	333a <memmove+0x28>

000000000000336a <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    336a:	1141                	addi	sp,sp,-16
    336c:	e422                	sd	s0,8(sp)
    336e:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    3370:	ca05                	beqz	a2,33a0 <memcmp+0x36>
    3372:	fff6069b          	addiw	a3,a2,-1
    3376:	1682                	slli	a3,a3,0x20
    3378:	9281                	srli	a3,a3,0x20
    337a:	0685                	addi	a3,a3,1
    337c:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    337e:	00054783          	lbu	a5,0(a0)
    3382:	0005c703          	lbu	a4,0(a1)
    3386:	00e79863          	bne	a5,a4,3396 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    338a:	0505                	addi	a0,a0,1
    p2++;
    338c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    338e:	fed518e3          	bne	a0,a3,337e <memcmp+0x14>
  }
  return 0;
    3392:	4501                	li	a0,0
    3394:	a019                	j	339a <memcmp+0x30>
      return *p1 - *p2;
    3396:	40e7853b          	subw	a0,a5,a4
}
    339a:	6422                	ld	s0,8(sp)
    339c:	0141                	addi	sp,sp,16
    339e:	8082                	ret
  return 0;
    33a0:	4501                	li	a0,0
    33a2:	bfe5                	j	339a <memcmp+0x30>

00000000000033a4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    33a4:	1141                	addi	sp,sp,-16
    33a6:	e406                	sd	ra,8(sp)
    33a8:	e022                	sd	s0,0(sp)
    33aa:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    33ac:	00000097          	auipc	ra,0x0
    33b0:	f66080e7          	jalr	-154(ra) # 3312 <memmove>
}
    33b4:	60a2                	ld	ra,8(sp)
    33b6:	6402                	ld	s0,0(sp)
    33b8:	0141                	addi	sp,sp,16
    33ba:	8082                	ret

00000000000033bc <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    33bc:	1141                	addi	sp,sp,-16
    33be:	e422                	sd	s0,8(sp)
    33c0:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    33c2:	00052023          	sw	zero,0(a0)
}  
    33c6:	6422                	ld	s0,8(sp)
    33c8:	0141                	addi	sp,sp,16
    33ca:	8082                	ret

00000000000033cc <lock>:

void lock(struct spinlock * lk) 
{    
    33cc:	1141                	addi	sp,sp,-16
    33ce:	e422                	sd	s0,8(sp)
    33d0:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    33d2:	4705                	li	a4,1
    33d4:	87ba                	mv	a5,a4
    33d6:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    33da:	2781                	sext.w	a5,a5
    33dc:	ffe5                	bnez	a5,33d4 <lock+0x8>
}  
    33de:	6422                	ld	s0,8(sp)
    33e0:	0141                	addi	sp,sp,16
    33e2:	8082                	ret

00000000000033e4 <unlock>:

void unlock(struct spinlock * lk) 
{   
    33e4:	1141                	addi	sp,sp,-16
    33e6:	e422                	sd	s0,8(sp)
    33e8:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    33ea:	0f50000f          	fence	iorw,ow
    33ee:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    33f2:	6422                	ld	s0,8(sp)
    33f4:	0141                	addi	sp,sp,16
    33f6:	8082                	ret

00000000000033f8 <isDigit>:

unsigned int isDigit(char *c) {
    33f8:	1141                	addi	sp,sp,-16
    33fa:	e422                	sd	s0,8(sp)
    33fc:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    33fe:	00054503          	lbu	a0,0(a0)
    3402:	fd05051b          	addiw	a0,a0,-48
    3406:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    340a:	00a53513          	sltiu	a0,a0,10
    340e:	6422                	ld	s0,8(sp)
    3410:	0141                	addi	sp,sp,16
    3412:	8082                	ret

0000000000003414 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    3414:	4885                	li	a7,1
 ecall
    3416:	00000073          	ecall
 ret
    341a:	8082                	ret

000000000000341c <exit>:
.global exit
exit:
 li a7, SYS_exit
    341c:	4889                	li	a7,2
 ecall
    341e:	00000073          	ecall
 ret
    3422:	8082                	ret

0000000000003424 <wait>:
.global wait
wait:
 li a7, SYS_wait
    3424:	488d                	li	a7,3
 ecall
    3426:	00000073          	ecall
 ret
    342a:	8082                	ret

000000000000342c <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    342c:	48e1                	li	a7,24
 ecall
    342e:	00000073          	ecall
 ret
    3432:	8082                	ret

0000000000003434 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    3434:	4891                	li	a7,4
 ecall
    3436:	00000073          	ecall
 ret
    343a:	8082                	ret

000000000000343c <read>:
.global read
read:
 li a7, SYS_read
    343c:	4895                	li	a7,5
 ecall
    343e:	00000073          	ecall
 ret
    3442:	8082                	ret

0000000000003444 <write>:
.global write
write:
 li a7, SYS_write
    3444:	48c1                	li	a7,16
 ecall
    3446:	00000073          	ecall
 ret
    344a:	8082                	ret

000000000000344c <close>:
.global close
close:
 li a7, SYS_close
    344c:	48d5                	li	a7,21
 ecall
    344e:	00000073          	ecall
 ret
    3452:	8082                	ret

0000000000003454 <kill>:
.global kill
kill:
 li a7, SYS_kill
    3454:	4899                	li	a7,6
 ecall
    3456:	00000073          	ecall
 ret
    345a:	8082                	ret

000000000000345c <exec>:
.global exec
exec:
 li a7, SYS_exec
    345c:	489d                	li	a7,7
 ecall
    345e:	00000073          	ecall
 ret
    3462:	8082                	ret

0000000000003464 <open>:
.global open
open:
 li a7, SYS_open
    3464:	48bd                	li	a7,15
 ecall
    3466:	00000073          	ecall
 ret
    346a:	8082                	ret

000000000000346c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    346c:	48c5                	li	a7,17
 ecall
    346e:	00000073          	ecall
 ret
    3472:	8082                	ret

0000000000003474 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    3474:	48c9                	li	a7,18
 ecall
    3476:	00000073          	ecall
 ret
    347a:	8082                	ret

000000000000347c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    347c:	48a1                	li	a7,8
 ecall
    347e:	00000073          	ecall
 ret
    3482:	8082                	ret

0000000000003484 <link>:
.global link
link:
 li a7, SYS_link
    3484:	48cd                	li	a7,19
 ecall
    3486:	00000073          	ecall
 ret
    348a:	8082                	ret

000000000000348c <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    348c:	48d1                	li	a7,20
 ecall
    348e:	00000073          	ecall
 ret
    3492:	8082                	ret

0000000000003494 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    3494:	48a5                	li	a7,9
 ecall
    3496:	00000073          	ecall
 ret
    349a:	8082                	ret

000000000000349c <dup>:
.global dup
dup:
 li a7, SYS_dup
    349c:	48a9                	li	a7,10
 ecall
    349e:	00000073          	ecall
 ret
    34a2:	8082                	ret

00000000000034a4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    34a4:	48ad                	li	a7,11
 ecall
    34a6:	00000073          	ecall
 ret
    34aa:	8082                	ret

00000000000034ac <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    34ac:	48b1                	li	a7,12
 ecall
    34ae:	00000073          	ecall
 ret
    34b2:	8082                	ret

00000000000034b4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    34b4:	48b5                	li	a7,13
 ecall
    34b6:	00000073          	ecall
 ret
    34ba:	8082                	ret

00000000000034bc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    34bc:	48b9                	li	a7,14
 ecall
    34be:	00000073          	ecall
 ret
    34c2:	8082                	ret

00000000000034c4 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    34c4:	48d9                	li	a7,22
 ecall
    34c6:	00000073          	ecall
 ret
    34ca:	8082                	ret

00000000000034cc <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    34cc:	48dd                	li	a7,23
 ecall
    34ce:	00000073          	ecall
 ret
    34d2:	8082                	ret

00000000000034d4 <ps>:
.global ps
ps:
 li a7, SYS_ps
    34d4:	48e5                	li	a7,25
 ecall
    34d6:	00000073          	ecall
 ret
    34da:	8082                	ret

00000000000034dc <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    34dc:	48e9                	li	a7,26
 ecall
    34de:	00000073          	ecall
 ret
    34e2:	8082                	ret

00000000000034e4 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    34e4:	48ed                	li	a7,27
 ecall
    34e6:	00000073          	ecall
 ret
    34ea:	8082                	ret

00000000000034ec <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    34ec:	1101                	addi	sp,sp,-32
    34ee:	ec06                	sd	ra,24(sp)
    34f0:	e822                	sd	s0,16(sp)
    34f2:	1000                	addi	s0,sp,32
    34f4:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    34f8:	4605                	li	a2,1
    34fa:	fef40593          	addi	a1,s0,-17
    34fe:	00000097          	auipc	ra,0x0
    3502:	f46080e7          	jalr	-186(ra) # 3444 <write>
}
    3506:	60e2                	ld	ra,24(sp)
    3508:	6442                	ld	s0,16(sp)
    350a:	6105                	addi	sp,sp,32
    350c:	8082                	ret

000000000000350e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    350e:	7139                	addi	sp,sp,-64
    3510:	fc06                	sd	ra,56(sp)
    3512:	f822                	sd	s0,48(sp)
    3514:	f426                	sd	s1,40(sp)
    3516:	f04a                	sd	s2,32(sp)
    3518:	ec4e                	sd	s3,24(sp)
    351a:	0080                	addi	s0,sp,64
    351c:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    351e:	c299                	beqz	a3,3524 <printint+0x16>
    3520:	0805c863          	bltz	a1,35b0 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3524:	2581                	sext.w	a1,a1
  neg = 0;
    3526:	4881                	li	a7,0
    3528:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    352c:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    352e:	2601                	sext.w	a2,a2
    3530:	00000517          	auipc	a0,0x0
    3534:	4b050513          	addi	a0,a0,1200 # 39e0 <digits>
    3538:	883a                	mv	a6,a4
    353a:	2705                	addiw	a4,a4,1
    353c:	02c5f7bb          	remuw	a5,a1,a2
    3540:	1782                	slli	a5,a5,0x20
    3542:	9381                	srli	a5,a5,0x20
    3544:	97aa                	add	a5,a5,a0
    3546:	0007c783          	lbu	a5,0(a5)
    354a:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    354e:	0005879b          	sext.w	a5,a1
    3552:	02c5d5bb          	divuw	a1,a1,a2
    3556:	0685                	addi	a3,a3,1
    3558:	fec7f0e3          	bgeu	a5,a2,3538 <printint+0x2a>
  if(neg)
    355c:	00088b63          	beqz	a7,3572 <printint+0x64>
    buf[i++] = '-';
    3560:	fd040793          	addi	a5,s0,-48
    3564:	973e                	add	a4,a4,a5
    3566:	02d00793          	li	a5,45
    356a:	fef70823          	sb	a5,-16(a4)
    356e:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    3572:	02e05863          	blez	a4,35a2 <printint+0x94>
    3576:	fc040793          	addi	a5,s0,-64
    357a:	00e78933          	add	s2,a5,a4
    357e:	fff78993          	addi	s3,a5,-1
    3582:	99ba                	add	s3,s3,a4
    3584:	377d                	addiw	a4,a4,-1
    3586:	1702                	slli	a4,a4,0x20
    3588:	9301                	srli	a4,a4,0x20
    358a:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    358e:	fff94583          	lbu	a1,-1(s2)
    3592:	8526                	mv	a0,s1
    3594:	00000097          	auipc	ra,0x0
    3598:	f58080e7          	jalr	-168(ra) # 34ec <putc>
  while(--i >= 0)
    359c:	197d                	addi	s2,s2,-1
    359e:	ff3918e3          	bne	s2,s3,358e <printint+0x80>
}
    35a2:	70e2                	ld	ra,56(sp)
    35a4:	7442                	ld	s0,48(sp)
    35a6:	74a2                	ld	s1,40(sp)
    35a8:	7902                	ld	s2,32(sp)
    35aa:	69e2                	ld	s3,24(sp)
    35ac:	6121                	addi	sp,sp,64
    35ae:	8082                	ret
    x = -xx;
    35b0:	40b005bb          	negw	a1,a1
    neg = 1;
    35b4:	4885                	li	a7,1
    x = -xx;
    35b6:	bf8d                	j	3528 <printint+0x1a>

00000000000035b8 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    35b8:	7119                	addi	sp,sp,-128
    35ba:	fc86                	sd	ra,120(sp)
    35bc:	f8a2                	sd	s0,112(sp)
    35be:	f4a6                	sd	s1,104(sp)
    35c0:	f0ca                	sd	s2,96(sp)
    35c2:	ecce                	sd	s3,88(sp)
    35c4:	e8d2                	sd	s4,80(sp)
    35c6:	e4d6                	sd	s5,72(sp)
    35c8:	e0da                	sd	s6,64(sp)
    35ca:	fc5e                	sd	s7,56(sp)
    35cc:	f862                	sd	s8,48(sp)
    35ce:	f466                	sd	s9,40(sp)
    35d0:	f06a                	sd	s10,32(sp)
    35d2:	ec6e                	sd	s11,24(sp)
    35d4:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    35d6:	0005c903          	lbu	s2,0(a1)
    35da:	18090f63          	beqz	s2,3778 <vprintf+0x1c0>
    35de:	8aaa                	mv	s5,a0
    35e0:	8b32                	mv	s6,a2
    35e2:	00158493          	addi	s1,a1,1
  state = 0;
    35e6:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    35e8:	02500a13          	li	s4,37
      if(c == 'd'){
    35ec:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    35f0:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    35f4:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    35f8:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    35fc:	00000b97          	auipc	s7,0x0
    3600:	3e4b8b93          	addi	s7,s7,996 # 39e0 <digits>
    3604:	a839                	j	3622 <vprintf+0x6a>
        putc(fd, c);
    3606:	85ca                	mv	a1,s2
    3608:	8556                	mv	a0,s5
    360a:	00000097          	auipc	ra,0x0
    360e:	ee2080e7          	jalr	-286(ra) # 34ec <putc>
    3612:	a019                	j	3618 <vprintf+0x60>
    } else if(state == '%'){
    3614:	01498f63          	beq	s3,s4,3632 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    3618:	0485                	addi	s1,s1,1
    361a:	fff4c903          	lbu	s2,-1(s1)
    361e:	14090d63          	beqz	s2,3778 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    3622:	0009079b          	sext.w	a5,s2
    if(state == 0){
    3626:	fe0997e3          	bnez	s3,3614 <vprintf+0x5c>
      if(c == '%'){
    362a:	fd479ee3          	bne	a5,s4,3606 <vprintf+0x4e>
        state = '%';
    362e:	89be                	mv	s3,a5
    3630:	b7e5                	j	3618 <vprintf+0x60>
      if(c == 'd'){
    3632:	05878063          	beq	a5,s8,3672 <vprintf+0xba>
      } else if(c == 'l') {
    3636:	05978c63          	beq	a5,s9,368e <vprintf+0xd6>
      } else if(c == 'x') {
    363a:	07a78863          	beq	a5,s10,36aa <vprintf+0xf2>
      } else if(c == 'p') {
    363e:	09b78463          	beq	a5,s11,36c6 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    3642:	07300713          	li	a4,115
    3646:	0ce78663          	beq	a5,a4,3712 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    364a:	06300713          	li	a4,99
    364e:	0ee78e63          	beq	a5,a4,374a <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    3652:	11478863          	beq	a5,s4,3762 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3656:	85d2                	mv	a1,s4
    3658:	8556                	mv	a0,s5
    365a:	00000097          	auipc	ra,0x0
    365e:	e92080e7          	jalr	-366(ra) # 34ec <putc>
        putc(fd, c);
    3662:	85ca                	mv	a1,s2
    3664:	8556                	mv	a0,s5
    3666:	00000097          	auipc	ra,0x0
    366a:	e86080e7          	jalr	-378(ra) # 34ec <putc>
      }
      state = 0;
    366e:	4981                	li	s3,0
    3670:	b765                	j	3618 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    3672:	008b0913          	addi	s2,s6,8
    3676:	4685                	li	a3,1
    3678:	4629                	li	a2,10
    367a:	000b2583          	lw	a1,0(s6)
    367e:	8556                	mv	a0,s5
    3680:	00000097          	auipc	ra,0x0
    3684:	e8e080e7          	jalr	-370(ra) # 350e <printint>
    3688:	8b4a                	mv	s6,s2
      state = 0;
    368a:	4981                	li	s3,0
    368c:	b771                	j	3618 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    368e:	008b0913          	addi	s2,s6,8
    3692:	4681                	li	a3,0
    3694:	4629                	li	a2,10
    3696:	000b2583          	lw	a1,0(s6)
    369a:	8556                	mv	a0,s5
    369c:	00000097          	auipc	ra,0x0
    36a0:	e72080e7          	jalr	-398(ra) # 350e <printint>
    36a4:	8b4a                	mv	s6,s2
      state = 0;
    36a6:	4981                	li	s3,0
    36a8:	bf85                	j	3618 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    36aa:	008b0913          	addi	s2,s6,8
    36ae:	4681                	li	a3,0
    36b0:	4641                	li	a2,16
    36b2:	000b2583          	lw	a1,0(s6)
    36b6:	8556                	mv	a0,s5
    36b8:	00000097          	auipc	ra,0x0
    36bc:	e56080e7          	jalr	-426(ra) # 350e <printint>
    36c0:	8b4a                	mv	s6,s2
      state = 0;
    36c2:	4981                	li	s3,0
    36c4:	bf91                	j	3618 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    36c6:	008b0793          	addi	a5,s6,8
    36ca:	f8f43423          	sd	a5,-120(s0)
    36ce:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    36d2:	03000593          	li	a1,48
    36d6:	8556                	mv	a0,s5
    36d8:	00000097          	auipc	ra,0x0
    36dc:	e14080e7          	jalr	-492(ra) # 34ec <putc>
  putc(fd, 'x');
    36e0:	85ea                	mv	a1,s10
    36e2:	8556                	mv	a0,s5
    36e4:	00000097          	auipc	ra,0x0
    36e8:	e08080e7          	jalr	-504(ra) # 34ec <putc>
    36ec:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    36ee:	03c9d793          	srli	a5,s3,0x3c
    36f2:	97de                	add	a5,a5,s7
    36f4:	0007c583          	lbu	a1,0(a5)
    36f8:	8556                	mv	a0,s5
    36fa:	00000097          	auipc	ra,0x0
    36fe:	df2080e7          	jalr	-526(ra) # 34ec <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    3702:	0992                	slli	s3,s3,0x4
    3704:	397d                	addiw	s2,s2,-1
    3706:	fe0914e3          	bnez	s2,36ee <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    370a:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    370e:	4981                	li	s3,0
    3710:	b721                	j	3618 <vprintf+0x60>
        s = va_arg(ap, char*);
    3712:	008b0993          	addi	s3,s6,8
    3716:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    371a:	02090163          	beqz	s2,373c <vprintf+0x184>
        while(*s != 0){
    371e:	00094583          	lbu	a1,0(s2)
    3722:	c9a1                	beqz	a1,3772 <vprintf+0x1ba>
          putc(fd, *s);
    3724:	8556                	mv	a0,s5
    3726:	00000097          	auipc	ra,0x0
    372a:	dc6080e7          	jalr	-570(ra) # 34ec <putc>
          s++;
    372e:	0905                	addi	s2,s2,1
        while(*s != 0){
    3730:	00094583          	lbu	a1,0(s2)
    3734:	f9e5                	bnez	a1,3724 <vprintf+0x16c>
        s = va_arg(ap, char*);
    3736:	8b4e                	mv	s6,s3
      state = 0;
    3738:	4981                	li	s3,0
    373a:	bdf9                	j	3618 <vprintf+0x60>
          s = "(null)";
    373c:	00000917          	auipc	s2,0x0
    3740:	29c90913          	addi	s2,s2,668 # 39d8 <malloc+0x156>
        while(*s != 0){
    3744:	02800593          	li	a1,40
    3748:	bff1                	j	3724 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    374a:	008b0913          	addi	s2,s6,8
    374e:	000b4583          	lbu	a1,0(s6)
    3752:	8556                	mv	a0,s5
    3754:	00000097          	auipc	ra,0x0
    3758:	d98080e7          	jalr	-616(ra) # 34ec <putc>
    375c:	8b4a                	mv	s6,s2
      state = 0;
    375e:	4981                	li	s3,0
    3760:	bd65                	j	3618 <vprintf+0x60>
        putc(fd, c);
    3762:	85d2                	mv	a1,s4
    3764:	8556                	mv	a0,s5
    3766:	00000097          	auipc	ra,0x0
    376a:	d86080e7          	jalr	-634(ra) # 34ec <putc>
      state = 0;
    376e:	4981                	li	s3,0
    3770:	b565                	j	3618 <vprintf+0x60>
        s = va_arg(ap, char*);
    3772:	8b4e                	mv	s6,s3
      state = 0;
    3774:	4981                	li	s3,0
    3776:	b54d                	j	3618 <vprintf+0x60>
    }
  }
}
    3778:	70e6                	ld	ra,120(sp)
    377a:	7446                	ld	s0,112(sp)
    377c:	74a6                	ld	s1,104(sp)
    377e:	7906                	ld	s2,96(sp)
    3780:	69e6                	ld	s3,88(sp)
    3782:	6a46                	ld	s4,80(sp)
    3784:	6aa6                	ld	s5,72(sp)
    3786:	6b06                	ld	s6,64(sp)
    3788:	7be2                	ld	s7,56(sp)
    378a:	7c42                	ld	s8,48(sp)
    378c:	7ca2                	ld	s9,40(sp)
    378e:	7d02                	ld	s10,32(sp)
    3790:	6de2                	ld	s11,24(sp)
    3792:	6109                	addi	sp,sp,128
    3794:	8082                	ret

0000000000003796 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    3796:	715d                	addi	sp,sp,-80
    3798:	ec06                	sd	ra,24(sp)
    379a:	e822                	sd	s0,16(sp)
    379c:	1000                	addi	s0,sp,32
    379e:	e010                	sd	a2,0(s0)
    37a0:	e414                	sd	a3,8(s0)
    37a2:	e818                	sd	a4,16(s0)
    37a4:	ec1c                	sd	a5,24(s0)
    37a6:	03043023          	sd	a6,32(s0)
    37aa:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    37ae:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    37b2:	8622                	mv	a2,s0
    37b4:	00000097          	auipc	ra,0x0
    37b8:	e04080e7          	jalr	-508(ra) # 35b8 <vprintf>
}
    37bc:	60e2                	ld	ra,24(sp)
    37be:	6442                	ld	s0,16(sp)
    37c0:	6161                	addi	sp,sp,80
    37c2:	8082                	ret

00000000000037c4 <printf>:

void
printf(const char *fmt, ...)
{
    37c4:	711d                	addi	sp,sp,-96
    37c6:	ec06                	sd	ra,24(sp)
    37c8:	e822                	sd	s0,16(sp)
    37ca:	1000                	addi	s0,sp,32
    37cc:	e40c                	sd	a1,8(s0)
    37ce:	e810                	sd	a2,16(s0)
    37d0:	ec14                	sd	a3,24(s0)
    37d2:	f018                	sd	a4,32(s0)
    37d4:	f41c                	sd	a5,40(s0)
    37d6:	03043823          	sd	a6,48(s0)
    37da:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    37de:	00840613          	addi	a2,s0,8
    37e2:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    37e6:	85aa                	mv	a1,a0
    37e8:	4505                	li	a0,1
    37ea:	00000097          	auipc	ra,0x0
    37ee:	dce080e7          	jalr	-562(ra) # 35b8 <vprintf>
}
    37f2:	60e2                	ld	ra,24(sp)
    37f4:	6442                	ld	s0,16(sp)
    37f6:	6125                	addi	sp,sp,96
    37f8:	8082                	ret

00000000000037fa <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    37fa:	1141                	addi	sp,sp,-16
    37fc:	e422                	sd	s0,8(sp)
    37fe:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3800:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3804:	00000797          	auipc	a5,0x0
    3808:	7fc7b783          	ld	a5,2044(a5) # 4000 <freep>
    380c:	a805                	j	383c <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    380e:	4618                	lw	a4,8(a2)
    3810:	9db9                	addw	a1,a1,a4
    3812:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    3816:	6398                	ld	a4,0(a5)
    3818:	6318                	ld	a4,0(a4)
    381a:	fee53823          	sd	a4,-16(a0)
    381e:	a091                	j	3862 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    3820:	ff852703          	lw	a4,-8(a0)
    3824:	9e39                	addw	a2,a2,a4
    3826:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    3828:	ff053703          	ld	a4,-16(a0)
    382c:	e398                	sd	a4,0(a5)
    382e:	a099                	j	3874 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3830:	6398                	ld	a4,0(a5)
    3832:	00e7e463          	bltu	a5,a4,383a <free+0x40>
    3836:	00e6ea63          	bltu	a3,a4,384a <free+0x50>
{
    383a:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    383c:	fed7fae3          	bgeu	a5,a3,3830 <free+0x36>
    3840:	6398                	ld	a4,0(a5)
    3842:	00e6e463          	bltu	a3,a4,384a <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3846:	fee7eae3          	bltu	a5,a4,383a <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    384a:	ff852583          	lw	a1,-8(a0)
    384e:	6390                	ld	a2,0(a5)
    3850:	02059713          	slli	a4,a1,0x20
    3854:	9301                	srli	a4,a4,0x20
    3856:	0712                	slli	a4,a4,0x4
    3858:	9736                	add	a4,a4,a3
    385a:	fae60ae3          	beq	a2,a4,380e <free+0x14>
    bp->s.ptr = p->s.ptr;
    385e:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    3862:	4790                	lw	a2,8(a5)
    3864:	02061713          	slli	a4,a2,0x20
    3868:	9301                	srli	a4,a4,0x20
    386a:	0712                	slli	a4,a4,0x4
    386c:	973e                	add	a4,a4,a5
    386e:	fae689e3          	beq	a3,a4,3820 <free+0x26>
  } else
    p->s.ptr = bp;
    3872:	e394                	sd	a3,0(a5)
  freep = p;
    3874:	00000717          	auipc	a4,0x0
    3878:	78f73623          	sd	a5,1932(a4) # 4000 <freep>
}
    387c:	6422                	ld	s0,8(sp)
    387e:	0141                	addi	sp,sp,16
    3880:	8082                	ret

0000000000003882 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3882:	7139                	addi	sp,sp,-64
    3884:	fc06                	sd	ra,56(sp)
    3886:	f822                	sd	s0,48(sp)
    3888:	f426                	sd	s1,40(sp)
    388a:	f04a                	sd	s2,32(sp)
    388c:	ec4e                	sd	s3,24(sp)
    388e:	e852                	sd	s4,16(sp)
    3890:	e456                	sd	s5,8(sp)
    3892:	e05a                	sd	s6,0(sp)
    3894:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3896:	02051493          	slli	s1,a0,0x20
    389a:	9081                	srli	s1,s1,0x20
    389c:	04bd                	addi	s1,s1,15
    389e:	8091                	srli	s1,s1,0x4
    38a0:	0014899b          	addiw	s3,s1,1
    38a4:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    38a6:	00000517          	auipc	a0,0x0
    38aa:	75a53503          	ld	a0,1882(a0) # 4000 <freep>
    38ae:	c515                	beqz	a0,38da <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    38b0:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    38b2:	4798                	lw	a4,8(a5)
    38b4:	02977f63          	bgeu	a4,s1,38f2 <malloc+0x70>
    38b8:	8a4e                	mv	s4,s3
    38ba:	0009871b          	sext.w	a4,s3
    38be:	6685                	lui	a3,0x1
    38c0:	00d77363          	bgeu	a4,a3,38c6 <malloc+0x44>
    38c4:	6a05                	lui	s4,0x1
    38c6:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    38ca:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    38ce:	00000917          	auipc	s2,0x0
    38d2:	73290913          	addi	s2,s2,1842 # 4000 <freep>
  if(p == (char*)-1)
    38d6:	5afd                	li	s5,-1
    38d8:	a88d                	j	394a <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    38da:	00000797          	auipc	a5,0x0
    38de:	73678793          	addi	a5,a5,1846 # 4010 <base>
    38e2:	00000717          	auipc	a4,0x0
    38e6:	70f73f23          	sd	a5,1822(a4) # 4000 <freep>
    38ea:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    38ec:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    38f0:	b7e1                	j	38b8 <malloc+0x36>
      if(p->s.size == nunits)
    38f2:	02e48b63          	beq	s1,a4,3928 <malloc+0xa6>
        p->s.size -= nunits;
    38f6:	4137073b          	subw	a4,a4,s3
    38fa:	c798                	sw	a4,8(a5)
        p += p->s.size;
    38fc:	1702                	slli	a4,a4,0x20
    38fe:	9301                	srli	a4,a4,0x20
    3900:	0712                	slli	a4,a4,0x4
    3902:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    3904:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    3908:	00000717          	auipc	a4,0x0
    390c:	6ea73c23          	sd	a0,1784(a4) # 4000 <freep>
      return (void*)(p + 1);
    3910:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3914:	70e2                	ld	ra,56(sp)
    3916:	7442                	ld	s0,48(sp)
    3918:	74a2                	ld	s1,40(sp)
    391a:	7902                	ld	s2,32(sp)
    391c:	69e2                	ld	s3,24(sp)
    391e:	6a42                	ld	s4,16(sp)
    3920:	6aa2                	ld	s5,8(sp)
    3922:	6b02                	ld	s6,0(sp)
    3924:	6121                	addi	sp,sp,64
    3926:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    3928:	6398                	ld	a4,0(a5)
    392a:	e118                	sd	a4,0(a0)
    392c:	bff1                	j	3908 <malloc+0x86>
  hp->s.size = nu;
    392e:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    3932:	0541                	addi	a0,a0,16
    3934:	00000097          	auipc	ra,0x0
    3938:	ec6080e7          	jalr	-314(ra) # 37fa <free>
  return freep;
    393c:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    3940:	d971                	beqz	a0,3914 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3942:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3944:	4798                	lw	a4,8(a5)
    3946:	fa9776e3          	bgeu	a4,s1,38f2 <malloc+0x70>
    if(p == freep)
    394a:	00093703          	ld	a4,0(s2)
    394e:	853e                	mv	a0,a5
    3950:	fef719e3          	bne	a4,a5,3942 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3954:	8552                	mv	a0,s4
    3956:	00000097          	auipc	ra,0x0
    395a:	b56080e7          	jalr	-1194(ra) # 34ac <sbrk>
  if(p == (char*)-1)
    395e:	fd5518e3          	bne	a0,s5,392e <malloc+0xac>
        return 0;
    3962:	4501                	li	a0,0
    3964:	bf45                	j	3914 <malloc+0x92>
