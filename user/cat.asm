
user/_cat:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <cat>:

char buf[512];

void
cat(int fd)
{
    3000:	7179                	addi	sp,sp,-48
    3002:	f406                	sd	ra,40(sp)
    3004:	f022                	sd	s0,32(sp)
    3006:	ec26                	sd	s1,24(sp)
    3008:	e84a                	sd	s2,16(sp)
    300a:	e44e                	sd	s3,8(sp)
    300c:	1800                	addi	s0,sp,48
    300e:	89aa                	mv	s3,a0
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
    3010:	00001917          	auipc	s2,0x1
    3014:	00090913          	mv	s2,s2
    3018:	20000613          	li	a2,512
    301c:	85ca                	mv	a1,s2
    301e:	854e                	mv	a0,s3
    3020:	00000097          	auipc	ra,0x0
    3024:	3fe080e7          	jalr	1022(ra) # 341e <read>
    3028:	84aa                	mv	s1,a0
    302a:	02a05963          	blez	a0,305c <cat+0x5c>
    if (write(1, buf, n) != n) {
    302e:	8626                	mv	a2,s1
    3030:	85ca                	mv	a1,s2
    3032:	4505                	li	a0,1
    3034:	00000097          	auipc	ra,0x0
    3038:	3f2080e7          	jalr	1010(ra) # 3426 <write>
    303c:	fc950ee3          	beq	a0,s1,3018 <cat+0x18>
      fprintf(2, "cat: write error\n");
    3040:	00001597          	auipc	a1,0x1
    3044:	91058593          	addi	a1,a1,-1776 # 3950 <malloc+0xec>
    3048:	4509                	li	a0,2
    304a:	00000097          	auipc	ra,0x0
    304e:	72e080e7          	jalr	1838(ra) # 3778 <fprintf>
      exit(1);
    3052:	4505                	li	a0,1
    3054:	00000097          	auipc	ra,0x0
    3058:	3aa080e7          	jalr	938(ra) # 33fe <exit>
    }
  }
  if(n < 0){
    305c:	00054963          	bltz	a0,306e <cat+0x6e>
    fprintf(2, "cat: read error\n");
    exit(1);
  }
}
    3060:	70a2                	ld	ra,40(sp)
    3062:	7402                	ld	s0,32(sp)
    3064:	64e2                	ld	s1,24(sp)
    3066:	6942                	ld	s2,16(sp)
    3068:	69a2                	ld	s3,8(sp)
    306a:	6145                	addi	sp,sp,48
    306c:	8082                	ret
    fprintf(2, "cat: read error\n");
    306e:	00001597          	auipc	a1,0x1
    3072:	8fa58593          	addi	a1,a1,-1798 # 3968 <malloc+0x104>
    3076:	4509                	li	a0,2
    3078:	00000097          	auipc	ra,0x0
    307c:	700080e7          	jalr	1792(ra) # 3778 <fprintf>
    exit(1);
    3080:	4505                	li	a0,1
    3082:	00000097          	auipc	ra,0x0
    3086:	37c080e7          	jalr	892(ra) # 33fe <exit>

000000000000308a <main>:

int
main(int argc, char *argv[])
{
    308a:	7179                	addi	sp,sp,-48
    308c:	f406                	sd	ra,40(sp)
    308e:	f022                	sd	s0,32(sp)
    3090:	ec26                	sd	s1,24(sp)
    3092:	e84a                	sd	s2,16(sp)
    3094:	e44e                	sd	s3,8(sp)
    3096:	e052                	sd	s4,0(sp)
    3098:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
    309a:	4785                	li	a5,1
    309c:	04a7d763          	bge	a5,a0,30ea <main+0x60>
    30a0:	00858913          	addi	s2,a1,8
    30a4:	ffe5099b          	addiw	s3,a0,-2
    30a8:	1982                	slli	s3,s3,0x20
    30aa:	0209d993          	srli	s3,s3,0x20
    30ae:	098e                	slli	s3,s3,0x3
    30b0:	05c1                	addi	a1,a1,16
    30b2:	99ae                	add	s3,s3,a1
    cat(0);
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
    30b4:	4581                	li	a1,0
    30b6:	00093503          	ld	a0,0(s2) # 4010 <buf>
    30ba:	00000097          	auipc	ra,0x0
    30be:	38c080e7          	jalr	908(ra) # 3446 <open>
    30c2:	84aa                	mv	s1,a0
    30c4:	02054d63          	bltz	a0,30fe <main+0x74>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
      exit(1);
    }
    cat(fd);
    30c8:	00000097          	auipc	ra,0x0
    30cc:	f38080e7          	jalr	-200(ra) # 3000 <cat>
    close(fd);
    30d0:	8526                	mv	a0,s1
    30d2:	00000097          	auipc	ra,0x0
    30d6:	35c080e7          	jalr	860(ra) # 342e <close>
  for(i = 1; i < argc; i++){
    30da:	0921                	addi	s2,s2,8
    30dc:	fd391ce3          	bne	s2,s3,30b4 <main+0x2a>
  }
  exit(0);
    30e0:	4501                	li	a0,0
    30e2:	00000097          	auipc	ra,0x0
    30e6:	31c080e7          	jalr	796(ra) # 33fe <exit>
    cat(0);
    30ea:	4501                	li	a0,0
    30ec:	00000097          	auipc	ra,0x0
    30f0:	f14080e7          	jalr	-236(ra) # 3000 <cat>
    exit(0);
    30f4:	4501                	li	a0,0
    30f6:	00000097          	auipc	ra,0x0
    30fa:	308080e7          	jalr	776(ra) # 33fe <exit>
      fprintf(2, "cat: cannot open %s\n", argv[i]);
    30fe:	00093603          	ld	a2,0(s2)
    3102:	00001597          	auipc	a1,0x1
    3106:	87e58593          	addi	a1,a1,-1922 # 3980 <malloc+0x11c>
    310a:	4509                	li	a0,2
    310c:	00000097          	auipc	ra,0x0
    3110:	66c080e7          	jalr	1644(ra) # 3778 <fprintf>
      exit(1);
    3114:	4505                	li	a0,1
    3116:	00000097          	auipc	ra,0x0
    311a:	2e8080e7          	jalr	744(ra) # 33fe <exit>

000000000000311e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    311e:	1141                	addi	sp,sp,-16
    3120:	e406                	sd	ra,8(sp)
    3122:	e022                	sd	s0,0(sp)
    3124:	0800                	addi	s0,sp,16
  extern int main();
  main();
    3126:	00000097          	auipc	ra,0x0
    312a:	f64080e7          	jalr	-156(ra) # 308a <main>
  exit(0);
    312e:	4501                	li	a0,0
    3130:	00000097          	auipc	ra,0x0
    3134:	2ce080e7          	jalr	718(ra) # 33fe <exit>

0000000000003138 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    3138:	1141                	addi	sp,sp,-16
    313a:	e422                	sd	s0,8(sp)
    313c:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    313e:	87aa                	mv	a5,a0
    3140:	0585                	addi	a1,a1,1
    3142:	0785                	addi	a5,a5,1
    3144:	fff5c703          	lbu	a4,-1(a1)
    3148:	fee78fa3          	sb	a4,-1(a5)
    314c:	fb75                	bnez	a4,3140 <strcpy+0x8>
    ;
  return os;
}
    314e:	6422                	ld	s0,8(sp)
    3150:	0141                	addi	sp,sp,16
    3152:	8082                	ret

0000000000003154 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3154:	1141                	addi	sp,sp,-16
    3156:	e422                	sd	s0,8(sp)
    3158:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    315a:	00054783          	lbu	a5,0(a0)
    315e:	cb91                	beqz	a5,3172 <strcmp+0x1e>
    3160:	0005c703          	lbu	a4,0(a1)
    3164:	00f71763          	bne	a4,a5,3172 <strcmp+0x1e>
    p++, q++;
    3168:	0505                	addi	a0,a0,1
    316a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    316c:	00054783          	lbu	a5,0(a0)
    3170:	fbe5                	bnez	a5,3160 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    3172:	0005c503          	lbu	a0,0(a1)
}
    3176:	40a7853b          	subw	a0,a5,a0
    317a:	6422                	ld	s0,8(sp)
    317c:	0141                	addi	sp,sp,16
    317e:	8082                	ret

0000000000003180 <strlen>:

uint
strlen(const char *s)
{
    3180:	1141                	addi	sp,sp,-16
    3182:	e422                	sd	s0,8(sp)
    3184:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    3186:	00054783          	lbu	a5,0(a0)
    318a:	cf91                	beqz	a5,31a6 <strlen+0x26>
    318c:	0505                	addi	a0,a0,1
    318e:	87aa                	mv	a5,a0
    3190:	4685                	li	a3,1
    3192:	9e89                	subw	a3,a3,a0
    3194:	00f6853b          	addw	a0,a3,a5
    3198:	0785                	addi	a5,a5,1
    319a:	fff7c703          	lbu	a4,-1(a5)
    319e:	fb7d                	bnez	a4,3194 <strlen+0x14>
    ;
  return n;
}
    31a0:	6422                	ld	s0,8(sp)
    31a2:	0141                	addi	sp,sp,16
    31a4:	8082                	ret
  for(n = 0; s[n]; n++)
    31a6:	4501                	li	a0,0
    31a8:	bfe5                	j	31a0 <strlen+0x20>

00000000000031aa <memset>:

void*
memset(void *dst, int c, uint n)
{
    31aa:	1141                	addi	sp,sp,-16
    31ac:	e422                	sd	s0,8(sp)
    31ae:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    31b0:	ca19                	beqz	a2,31c6 <memset+0x1c>
    31b2:	87aa                	mv	a5,a0
    31b4:	1602                	slli	a2,a2,0x20
    31b6:	9201                	srli	a2,a2,0x20
    31b8:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    31bc:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    31c0:	0785                	addi	a5,a5,1
    31c2:	fee79de3          	bne	a5,a4,31bc <memset+0x12>
  }
  return dst;
}
    31c6:	6422                	ld	s0,8(sp)
    31c8:	0141                	addi	sp,sp,16
    31ca:	8082                	ret

00000000000031cc <strchr>:

char*
strchr(const char *s, char c)
{
    31cc:	1141                	addi	sp,sp,-16
    31ce:	e422                	sd	s0,8(sp)
    31d0:	0800                	addi	s0,sp,16
  for(; *s; s++)
    31d2:	00054783          	lbu	a5,0(a0)
    31d6:	cb99                	beqz	a5,31ec <strchr+0x20>
    if(*s == c)
    31d8:	00f58763          	beq	a1,a5,31e6 <strchr+0x1a>
  for(; *s; s++)
    31dc:	0505                	addi	a0,a0,1
    31de:	00054783          	lbu	a5,0(a0)
    31e2:	fbfd                	bnez	a5,31d8 <strchr+0xc>
      return (char*)s;
  return 0;
    31e4:	4501                	li	a0,0
}
    31e6:	6422                	ld	s0,8(sp)
    31e8:	0141                	addi	sp,sp,16
    31ea:	8082                	ret
  return 0;
    31ec:	4501                	li	a0,0
    31ee:	bfe5                	j	31e6 <strchr+0x1a>

00000000000031f0 <gets>:

char*
gets(char *buf, int max)
{
    31f0:	711d                	addi	sp,sp,-96
    31f2:	ec86                	sd	ra,88(sp)
    31f4:	e8a2                	sd	s0,80(sp)
    31f6:	e4a6                	sd	s1,72(sp)
    31f8:	e0ca                	sd	s2,64(sp)
    31fa:	fc4e                	sd	s3,56(sp)
    31fc:	f852                	sd	s4,48(sp)
    31fe:	f456                	sd	s5,40(sp)
    3200:	f05a                	sd	s6,32(sp)
    3202:	ec5e                	sd	s7,24(sp)
    3204:	1080                	addi	s0,sp,96
    3206:	8baa                	mv	s7,a0
    3208:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    320a:	892a                	mv	s2,a0
    320c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    320e:	4aa9                	li	s5,10
    3210:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    3212:	89a6                	mv	s3,s1
    3214:	2485                	addiw	s1,s1,1
    3216:	0344d863          	bge	s1,s4,3246 <gets+0x56>
    cc = read(0, &c, 1);
    321a:	4605                	li	a2,1
    321c:	faf40593          	addi	a1,s0,-81
    3220:	4501                	li	a0,0
    3222:	00000097          	auipc	ra,0x0
    3226:	1fc080e7          	jalr	508(ra) # 341e <read>
    if(cc < 1)
    322a:	00a05e63          	blez	a0,3246 <gets+0x56>
    buf[i++] = c;
    322e:	faf44783          	lbu	a5,-81(s0)
    3232:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    3236:	01578763          	beq	a5,s5,3244 <gets+0x54>
    323a:	0905                	addi	s2,s2,1
    323c:	fd679be3          	bne	a5,s6,3212 <gets+0x22>
  for(i=0; i+1 < max; ){
    3240:	89a6                	mv	s3,s1
    3242:	a011                	j	3246 <gets+0x56>
    3244:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    3246:	99de                	add	s3,s3,s7
    3248:	00098023          	sb	zero,0(s3)
  return buf;
}
    324c:	855e                	mv	a0,s7
    324e:	60e6                	ld	ra,88(sp)
    3250:	6446                	ld	s0,80(sp)
    3252:	64a6                	ld	s1,72(sp)
    3254:	6906                	ld	s2,64(sp)
    3256:	79e2                	ld	s3,56(sp)
    3258:	7a42                	ld	s4,48(sp)
    325a:	7aa2                	ld	s5,40(sp)
    325c:	7b02                	ld	s6,32(sp)
    325e:	6be2                	ld	s7,24(sp)
    3260:	6125                	addi	sp,sp,96
    3262:	8082                	ret

0000000000003264 <stat>:

int
stat(const char *n, struct stat *st)
{
    3264:	1101                	addi	sp,sp,-32
    3266:	ec06                	sd	ra,24(sp)
    3268:	e822                	sd	s0,16(sp)
    326a:	e426                	sd	s1,8(sp)
    326c:	e04a                	sd	s2,0(sp)
    326e:	1000                	addi	s0,sp,32
    3270:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3272:	4581                	li	a1,0
    3274:	00000097          	auipc	ra,0x0
    3278:	1d2080e7          	jalr	466(ra) # 3446 <open>
  if(fd < 0)
    327c:	02054563          	bltz	a0,32a6 <stat+0x42>
    3280:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    3282:	85ca                	mv	a1,s2
    3284:	00000097          	auipc	ra,0x0
    3288:	1da080e7          	jalr	474(ra) # 345e <fstat>
    328c:	892a                	mv	s2,a0
  close(fd);
    328e:	8526                	mv	a0,s1
    3290:	00000097          	auipc	ra,0x0
    3294:	19e080e7          	jalr	414(ra) # 342e <close>
  return r;
}
    3298:	854a                	mv	a0,s2
    329a:	60e2                	ld	ra,24(sp)
    329c:	6442                	ld	s0,16(sp)
    329e:	64a2                	ld	s1,8(sp)
    32a0:	6902                	ld	s2,0(sp)
    32a2:	6105                	addi	sp,sp,32
    32a4:	8082                	ret
    return -1;
    32a6:	597d                	li	s2,-1
    32a8:	bfc5                	j	3298 <stat+0x34>

00000000000032aa <atoi>:

int
atoi(const char *s)
{
    32aa:	1141                	addi	sp,sp,-16
    32ac:	e422                	sd	s0,8(sp)
    32ae:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    32b0:	00054603          	lbu	a2,0(a0)
    32b4:	fd06079b          	addiw	a5,a2,-48
    32b8:	0ff7f793          	andi	a5,a5,255
    32bc:	4725                	li	a4,9
    32be:	02f76963          	bltu	a4,a5,32f0 <atoi+0x46>
    32c2:	86aa                	mv	a3,a0
  n = 0;
    32c4:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    32c6:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    32c8:	0685                	addi	a3,a3,1
    32ca:	0025179b          	slliw	a5,a0,0x2
    32ce:	9fa9                	addw	a5,a5,a0
    32d0:	0017979b          	slliw	a5,a5,0x1
    32d4:	9fb1                	addw	a5,a5,a2
    32d6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    32da:	0006c603          	lbu	a2,0(a3)
    32de:	fd06071b          	addiw	a4,a2,-48
    32e2:	0ff77713          	andi	a4,a4,255
    32e6:	fee5f1e3          	bgeu	a1,a4,32c8 <atoi+0x1e>
  return n;
}
    32ea:	6422                	ld	s0,8(sp)
    32ec:	0141                	addi	sp,sp,16
    32ee:	8082                	ret
  n = 0;
    32f0:	4501                	li	a0,0
    32f2:	bfe5                	j	32ea <atoi+0x40>

00000000000032f4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    32f4:	1141                	addi	sp,sp,-16
    32f6:	e422                	sd	s0,8(sp)
    32f8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    32fa:	02b57463          	bgeu	a0,a1,3322 <memmove+0x2e>
    while(n-- > 0)
    32fe:	00c05f63          	blez	a2,331c <memmove+0x28>
    3302:	1602                	slli	a2,a2,0x20
    3304:	9201                	srli	a2,a2,0x20
    3306:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    330a:	872a                	mv	a4,a0
      *dst++ = *src++;
    330c:	0585                	addi	a1,a1,1
    330e:	0705                	addi	a4,a4,1
    3310:	fff5c683          	lbu	a3,-1(a1)
    3314:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    3318:	fee79ae3          	bne	a5,a4,330c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    331c:	6422                	ld	s0,8(sp)
    331e:	0141                	addi	sp,sp,16
    3320:	8082                	ret
    dst += n;
    3322:	00c50733          	add	a4,a0,a2
    src += n;
    3326:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    3328:	fec05ae3          	blez	a2,331c <memmove+0x28>
    332c:	fff6079b          	addiw	a5,a2,-1
    3330:	1782                	slli	a5,a5,0x20
    3332:	9381                	srli	a5,a5,0x20
    3334:	fff7c793          	not	a5,a5
    3338:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    333a:	15fd                	addi	a1,a1,-1
    333c:	177d                	addi	a4,a4,-1
    333e:	0005c683          	lbu	a3,0(a1)
    3342:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    3346:	fee79ae3          	bne	a5,a4,333a <memmove+0x46>
    334a:	bfc9                	j	331c <memmove+0x28>

000000000000334c <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    334c:	1141                	addi	sp,sp,-16
    334e:	e422                	sd	s0,8(sp)
    3350:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    3352:	ca05                	beqz	a2,3382 <memcmp+0x36>
    3354:	fff6069b          	addiw	a3,a2,-1
    3358:	1682                	slli	a3,a3,0x20
    335a:	9281                	srli	a3,a3,0x20
    335c:	0685                	addi	a3,a3,1
    335e:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    3360:	00054783          	lbu	a5,0(a0)
    3364:	0005c703          	lbu	a4,0(a1)
    3368:	00e79863          	bne	a5,a4,3378 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    336c:	0505                	addi	a0,a0,1
    p2++;
    336e:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    3370:	fed518e3          	bne	a0,a3,3360 <memcmp+0x14>
  }
  return 0;
    3374:	4501                	li	a0,0
    3376:	a019                	j	337c <memcmp+0x30>
      return *p1 - *p2;
    3378:	40e7853b          	subw	a0,a5,a4
}
    337c:	6422                	ld	s0,8(sp)
    337e:	0141                	addi	sp,sp,16
    3380:	8082                	ret
  return 0;
    3382:	4501                	li	a0,0
    3384:	bfe5                	j	337c <memcmp+0x30>

0000000000003386 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    3386:	1141                	addi	sp,sp,-16
    3388:	e406                	sd	ra,8(sp)
    338a:	e022                	sd	s0,0(sp)
    338c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    338e:	00000097          	auipc	ra,0x0
    3392:	f66080e7          	jalr	-154(ra) # 32f4 <memmove>
}
    3396:	60a2                	ld	ra,8(sp)
    3398:	6402                	ld	s0,0(sp)
    339a:	0141                	addi	sp,sp,16
    339c:	8082                	ret

000000000000339e <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    339e:	1141                	addi	sp,sp,-16
    33a0:	e422                	sd	s0,8(sp)
    33a2:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    33a4:	00052023          	sw	zero,0(a0)
}  
    33a8:	6422                	ld	s0,8(sp)
    33aa:	0141                	addi	sp,sp,16
    33ac:	8082                	ret

00000000000033ae <lock>:

void lock(struct spinlock * lk) 
{    
    33ae:	1141                	addi	sp,sp,-16
    33b0:	e422                	sd	s0,8(sp)
    33b2:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    33b4:	4705                	li	a4,1
    33b6:	87ba                	mv	a5,a4
    33b8:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    33bc:	2781                	sext.w	a5,a5
    33be:	ffe5                	bnez	a5,33b6 <lock+0x8>
}  
    33c0:	6422                	ld	s0,8(sp)
    33c2:	0141                	addi	sp,sp,16
    33c4:	8082                	ret

00000000000033c6 <unlock>:

void unlock(struct spinlock * lk) 
{   
    33c6:	1141                	addi	sp,sp,-16
    33c8:	e422                	sd	s0,8(sp)
    33ca:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    33cc:	0f50000f          	fence	iorw,ow
    33d0:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    33d4:	6422                	ld	s0,8(sp)
    33d6:	0141                	addi	sp,sp,16
    33d8:	8082                	ret

00000000000033da <isDigit>:

unsigned int isDigit(char *c) {
    33da:	1141                	addi	sp,sp,-16
    33dc:	e422                	sd	s0,8(sp)
    33de:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    33e0:	00054503          	lbu	a0,0(a0)
    33e4:	fd05051b          	addiw	a0,a0,-48
    33e8:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    33ec:	00a53513          	sltiu	a0,a0,10
    33f0:	6422                	ld	s0,8(sp)
    33f2:	0141                	addi	sp,sp,16
    33f4:	8082                	ret

00000000000033f6 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    33f6:	4885                	li	a7,1
 ecall
    33f8:	00000073          	ecall
 ret
    33fc:	8082                	ret

00000000000033fe <exit>:
.global exit
exit:
 li a7, SYS_exit
    33fe:	4889                	li	a7,2
 ecall
    3400:	00000073          	ecall
 ret
    3404:	8082                	ret

0000000000003406 <wait>:
.global wait
wait:
 li a7, SYS_wait
    3406:	488d                	li	a7,3
 ecall
    3408:	00000073          	ecall
 ret
    340c:	8082                	ret

000000000000340e <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    340e:	48e1                	li	a7,24
 ecall
    3410:	00000073          	ecall
 ret
    3414:	8082                	ret

0000000000003416 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    3416:	4891                	li	a7,4
 ecall
    3418:	00000073          	ecall
 ret
    341c:	8082                	ret

000000000000341e <read>:
.global read
read:
 li a7, SYS_read
    341e:	4895                	li	a7,5
 ecall
    3420:	00000073          	ecall
 ret
    3424:	8082                	ret

0000000000003426 <write>:
.global write
write:
 li a7, SYS_write
    3426:	48c1                	li	a7,16
 ecall
    3428:	00000073          	ecall
 ret
    342c:	8082                	ret

000000000000342e <close>:
.global close
close:
 li a7, SYS_close
    342e:	48d5                	li	a7,21
 ecall
    3430:	00000073          	ecall
 ret
    3434:	8082                	ret

0000000000003436 <kill>:
.global kill
kill:
 li a7, SYS_kill
    3436:	4899                	li	a7,6
 ecall
    3438:	00000073          	ecall
 ret
    343c:	8082                	ret

000000000000343e <exec>:
.global exec
exec:
 li a7, SYS_exec
    343e:	489d                	li	a7,7
 ecall
    3440:	00000073          	ecall
 ret
    3444:	8082                	ret

0000000000003446 <open>:
.global open
open:
 li a7, SYS_open
    3446:	48bd                	li	a7,15
 ecall
    3448:	00000073          	ecall
 ret
    344c:	8082                	ret

000000000000344e <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    344e:	48c5                	li	a7,17
 ecall
    3450:	00000073          	ecall
 ret
    3454:	8082                	ret

0000000000003456 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    3456:	48c9                	li	a7,18
 ecall
    3458:	00000073          	ecall
 ret
    345c:	8082                	ret

000000000000345e <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    345e:	48a1                	li	a7,8
 ecall
    3460:	00000073          	ecall
 ret
    3464:	8082                	ret

0000000000003466 <link>:
.global link
link:
 li a7, SYS_link
    3466:	48cd                	li	a7,19
 ecall
    3468:	00000073          	ecall
 ret
    346c:	8082                	ret

000000000000346e <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    346e:	48d1                	li	a7,20
 ecall
    3470:	00000073          	ecall
 ret
    3474:	8082                	ret

0000000000003476 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    3476:	48a5                	li	a7,9
 ecall
    3478:	00000073          	ecall
 ret
    347c:	8082                	ret

000000000000347e <dup>:
.global dup
dup:
 li a7, SYS_dup
    347e:	48a9                	li	a7,10
 ecall
    3480:	00000073          	ecall
 ret
    3484:	8082                	ret

0000000000003486 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    3486:	48ad                	li	a7,11
 ecall
    3488:	00000073          	ecall
 ret
    348c:	8082                	ret

000000000000348e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    348e:	48b1                	li	a7,12
 ecall
    3490:	00000073          	ecall
 ret
    3494:	8082                	ret

0000000000003496 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    3496:	48b5                	li	a7,13
 ecall
    3498:	00000073          	ecall
 ret
    349c:	8082                	ret

000000000000349e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    349e:	48b9                	li	a7,14
 ecall
    34a0:	00000073          	ecall
 ret
    34a4:	8082                	ret

00000000000034a6 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    34a6:	48d9                	li	a7,22
 ecall
    34a8:	00000073          	ecall
 ret
    34ac:	8082                	ret

00000000000034ae <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    34ae:	48dd                	li	a7,23
 ecall
    34b0:	00000073          	ecall
 ret
    34b4:	8082                	ret

00000000000034b6 <ps>:
.global ps
ps:
 li a7, SYS_ps
    34b6:	48e5                	li	a7,25
 ecall
    34b8:	00000073          	ecall
 ret
    34bc:	8082                	ret

00000000000034be <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    34be:	48e9                	li	a7,26
 ecall
    34c0:	00000073          	ecall
 ret
    34c4:	8082                	ret

00000000000034c6 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    34c6:	48ed                	li	a7,27
 ecall
    34c8:	00000073          	ecall
 ret
    34cc:	8082                	ret

00000000000034ce <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    34ce:	1101                	addi	sp,sp,-32
    34d0:	ec06                	sd	ra,24(sp)
    34d2:	e822                	sd	s0,16(sp)
    34d4:	1000                	addi	s0,sp,32
    34d6:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    34da:	4605                	li	a2,1
    34dc:	fef40593          	addi	a1,s0,-17
    34e0:	00000097          	auipc	ra,0x0
    34e4:	f46080e7          	jalr	-186(ra) # 3426 <write>
}
    34e8:	60e2                	ld	ra,24(sp)
    34ea:	6442                	ld	s0,16(sp)
    34ec:	6105                	addi	sp,sp,32
    34ee:	8082                	ret

00000000000034f0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    34f0:	7139                	addi	sp,sp,-64
    34f2:	fc06                	sd	ra,56(sp)
    34f4:	f822                	sd	s0,48(sp)
    34f6:	f426                	sd	s1,40(sp)
    34f8:	f04a                	sd	s2,32(sp)
    34fa:	ec4e                	sd	s3,24(sp)
    34fc:	0080                	addi	s0,sp,64
    34fe:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3500:	c299                	beqz	a3,3506 <printint+0x16>
    3502:	0805c863          	bltz	a1,3592 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3506:	2581                	sext.w	a1,a1
  neg = 0;
    3508:	4881                	li	a7,0
    350a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    350e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    3510:	2601                	sext.w	a2,a2
    3512:	00000517          	auipc	a0,0x0
    3516:	48e50513          	addi	a0,a0,1166 # 39a0 <digits>
    351a:	883a                	mv	a6,a4
    351c:	2705                	addiw	a4,a4,1
    351e:	02c5f7bb          	remuw	a5,a1,a2
    3522:	1782                	slli	a5,a5,0x20
    3524:	9381                	srli	a5,a5,0x20
    3526:	97aa                	add	a5,a5,a0
    3528:	0007c783          	lbu	a5,0(a5)
    352c:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    3530:	0005879b          	sext.w	a5,a1
    3534:	02c5d5bb          	divuw	a1,a1,a2
    3538:	0685                	addi	a3,a3,1
    353a:	fec7f0e3          	bgeu	a5,a2,351a <printint+0x2a>
  if(neg)
    353e:	00088b63          	beqz	a7,3554 <printint+0x64>
    buf[i++] = '-';
    3542:	fd040793          	addi	a5,s0,-48
    3546:	973e                	add	a4,a4,a5
    3548:	02d00793          	li	a5,45
    354c:	fef70823          	sb	a5,-16(a4)
    3550:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    3554:	02e05863          	blez	a4,3584 <printint+0x94>
    3558:	fc040793          	addi	a5,s0,-64
    355c:	00e78933          	add	s2,a5,a4
    3560:	fff78993          	addi	s3,a5,-1
    3564:	99ba                	add	s3,s3,a4
    3566:	377d                	addiw	a4,a4,-1
    3568:	1702                	slli	a4,a4,0x20
    356a:	9301                	srli	a4,a4,0x20
    356c:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    3570:	fff94583          	lbu	a1,-1(s2)
    3574:	8526                	mv	a0,s1
    3576:	00000097          	auipc	ra,0x0
    357a:	f58080e7          	jalr	-168(ra) # 34ce <putc>
  while(--i >= 0)
    357e:	197d                	addi	s2,s2,-1
    3580:	ff3918e3          	bne	s2,s3,3570 <printint+0x80>
}
    3584:	70e2                	ld	ra,56(sp)
    3586:	7442                	ld	s0,48(sp)
    3588:	74a2                	ld	s1,40(sp)
    358a:	7902                	ld	s2,32(sp)
    358c:	69e2                	ld	s3,24(sp)
    358e:	6121                	addi	sp,sp,64
    3590:	8082                	ret
    x = -xx;
    3592:	40b005bb          	negw	a1,a1
    neg = 1;
    3596:	4885                	li	a7,1
    x = -xx;
    3598:	bf8d                	j	350a <printint+0x1a>

000000000000359a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    359a:	7119                	addi	sp,sp,-128
    359c:	fc86                	sd	ra,120(sp)
    359e:	f8a2                	sd	s0,112(sp)
    35a0:	f4a6                	sd	s1,104(sp)
    35a2:	f0ca                	sd	s2,96(sp)
    35a4:	ecce                	sd	s3,88(sp)
    35a6:	e8d2                	sd	s4,80(sp)
    35a8:	e4d6                	sd	s5,72(sp)
    35aa:	e0da                	sd	s6,64(sp)
    35ac:	fc5e                	sd	s7,56(sp)
    35ae:	f862                	sd	s8,48(sp)
    35b0:	f466                	sd	s9,40(sp)
    35b2:	f06a                	sd	s10,32(sp)
    35b4:	ec6e                	sd	s11,24(sp)
    35b6:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    35b8:	0005c903          	lbu	s2,0(a1)
    35bc:	18090f63          	beqz	s2,375a <vprintf+0x1c0>
    35c0:	8aaa                	mv	s5,a0
    35c2:	8b32                	mv	s6,a2
    35c4:	00158493          	addi	s1,a1,1
  state = 0;
    35c8:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    35ca:	02500a13          	li	s4,37
      if(c == 'd'){
    35ce:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    35d2:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    35d6:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    35da:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    35de:	00000b97          	auipc	s7,0x0
    35e2:	3c2b8b93          	addi	s7,s7,962 # 39a0 <digits>
    35e6:	a839                	j	3604 <vprintf+0x6a>
        putc(fd, c);
    35e8:	85ca                	mv	a1,s2
    35ea:	8556                	mv	a0,s5
    35ec:	00000097          	auipc	ra,0x0
    35f0:	ee2080e7          	jalr	-286(ra) # 34ce <putc>
    35f4:	a019                	j	35fa <vprintf+0x60>
    } else if(state == '%'){
    35f6:	01498f63          	beq	s3,s4,3614 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    35fa:	0485                	addi	s1,s1,1
    35fc:	fff4c903          	lbu	s2,-1(s1)
    3600:	14090d63          	beqz	s2,375a <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    3604:	0009079b          	sext.w	a5,s2
    if(state == 0){
    3608:	fe0997e3          	bnez	s3,35f6 <vprintf+0x5c>
      if(c == '%'){
    360c:	fd479ee3          	bne	a5,s4,35e8 <vprintf+0x4e>
        state = '%';
    3610:	89be                	mv	s3,a5
    3612:	b7e5                	j	35fa <vprintf+0x60>
      if(c == 'd'){
    3614:	05878063          	beq	a5,s8,3654 <vprintf+0xba>
      } else if(c == 'l') {
    3618:	05978c63          	beq	a5,s9,3670 <vprintf+0xd6>
      } else if(c == 'x') {
    361c:	07a78863          	beq	a5,s10,368c <vprintf+0xf2>
      } else if(c == 'p') {
    3620:	09b78463          	beq	a5,s11,36a8 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    3624:	07300713          	li	a4,115
    3628:	0ce78663          	beq	a5,a4,36f4 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    362c:	06300713          	li	a4,99
    3630:	0ee78e63          	beq	a5,a4,372c <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    3634:	11478863          	beq	a5,s4,3744 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    3638:	85d2                	mv	a1,s4
    363a:	8556                	mv	a0,s5
    363c:	00000097          	auipc	ra,0x0
    3640:	e92080e7          	jalr	-366(ra) # 34ce <putc>
        putc(fd, c);
    3644:	85ca                	mv	a1,s2
    3646:	8556                	mv	a0,s5
    3648:	00000097          	auipc	ra,0x0
    364c:	e86080e7          	jalr	-378(ra) # 34ce <putc>
      }
      state = 0;
    3650:	4981                	li	s3,0
    3652:	b765                	j	35fa <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    3654:	008b0913          	addi	s2,s6,8
    3658:	4685                	li	a3,1
    365a:	4629                	li	a2,10
    365c:	000b2583          	lw	a1,0(s6)
    3660:	8556                	mv	a0,s5
    3662:	00000097          	auipc	ra,0x0
    3666:	e8e080e7          	jalr	-370(ra) # 34f0 <printint>
    366a:	8b4a                	mv	s6,s2
      state = 0;
    366c:	4981                	li	s3,0
    366e:	b771                	j	35fa <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    3670:	008b0913          	addi	s2,s6,8
    3674:	4681                	li	a3,0
    3676:	4629                	li	a2,10
    3678:	000b2583          	lw	a1,0(s6)
    367c:	8556                	mv	a0,s5
    367e:	00000097          	auipc	ra,0x0
    3682:	e72080e7          	jalr	-398(ra) # 34f0 <printint>
    3686:	8b4a                	mv	s6,s2
      state = 0;
    3688:	4981                	li	s3,0
    368a:	bf85                	j	35fa <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    368c:	008b0913          	addi	s2,s6,8
    3690:	4681                	li	a3,0
    3692:	4641                	li	a2,16
    3694:	000b2583          	lw	a1,0(s6)
    3698:	8556                	mv	a0,s5
    369a:	00000097          	auipc	ra,0x0
    369e:	e56080e7          	jalr	-426(ra) # 34f0 <printint>
    36a2:	8b4a                	mv	s6,s2
      state = 0;
    36a4:	4981                	li	s3,0
    36a6:	bf91                	j	35fa <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    36a8:	008b0793          	addi	a5,s6,8
    36ac:	f8f43423          	sd	a5,-120(s0)
    36b0:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    36b4:	03000593          	li	a1,48
    36b8:	8556                	mv	a0,s5
    36ba:	00000097          	auipc	ra,0x0
    36be:	e14080e7          	jalr	-492(ra) # 34ce <putc>
  putc(fd, 'x');
    36c2:	85ea                	mv	a1,s10
    36c4:	8556                	mv	a0,s5
    36c6:	00000097          	auipc	ra,0x0
    36ca:	e08080e7          	jalr	-504(ra) # 34ce <putc>
    36ce:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    36d0:	03c9d793          	srli	a5,s3,0x3c
    36d4:	97de                	add	a5,a5,s7
    36d6:	0007c583          	lbu	a1,0(a5)
    36da:	8556                	mv	a0,s5
    36dc:	00000097          	auipc	ra,0x0
    36e0:	df2080e7          	jalr	-526(ra) # 34ce <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    36e4:	0992                	slli	s3,s3,0x4
    36e6:	397d                	addiw	s2,s2,-1
    36e8:	fe0914e3          	bnez	s2,36d0 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    36ec:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    36f0:	4981                	li	s3,0
    36f2:	b721                	j	35fa <vprintf+0x60>
        s = va_arg(ap, char*);
    36f4:	008b0993          	addi	s3,s6,8
    36f8:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    36fc:	02090163          	beqz	s2,371e <vprintf+0x184>
        while(*s != 0){
    3700:	00094583          	lbu	a1,0(s2)
    3704:	c9a1                	beqz	a1,3754 <vprintf+0x1ba>
          putc(fd, *s);
    3706:	8556                	mv	a0,s5
    3708:	00000097          	auipc	ra,0x0
    370c:	dc6080e7          	jalr	-570(ra) # 34ce <putc>
          s++;
    3710:	0905                	addi	s2,s2,1
        while(*s != 0){
    3712:	00094583          	lbu	a1,0(s2)
    3716:	f9e5                	bnez	a1,3706 <vprintf+0x16c>
        s = va_arg(ap, char*);
    3718:	8b4e                	mv	s6,s3
      state = 0;
    371a:	4981                	li	s3,0
    371c:	bdf9                	j	35fa <vprintf+0x60>
          s = "(null)";
    371e:	00000917          	auipc	s2,0x0
    3722:	27a90913          	addi	s2,s2,634 # 3998 <malloc+0x134>
        while(*s != 0){
    3726:	02800593          	li	a1,40
    372a:	bff1                	j	3706 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    372c:	008b0913          	addi	s2,s6,8
    3730:	000b4583          	lbu	a1,0(s6)
    3734:	8556                	mv	a0,s5
    3736:	00000097          	auipc	ra,0x0
    373a:	d98080e7          	jalr	-616(ra) # 34ce <putc>
    373e:	8b4a                	mv	s6,s2
      state = 0;
    3740:	4981                	li	s3,0
    3742:	bd65                	j	35fa <vprintf+0x60>
        putc(fd, c);
    3744:	85d2                	mv	a1,s4
    3746:	8556                	mv	a0,s5
    3748:	00000097          	auipc	ra,0x0
    374c:	d86080e7          	jalr	-634(ra) # 34ce <putc>
      state = 0;
    3750:	4981                	li	s3,0
    3752:	b565                	j	35fa <vprintf+0x60>
        s = va_arg(ap, char*);
    3754:	8b4e                	mv	s6,s3
      state = 0;
    3756:	4981                	li	s3,0
    3758:	b54d                	j	35fa <vprintf+0x60>
    }
  }
}
    375a:	70e6                	ld	ra,120(sp)
    375c:	7446                	ld	s0,112(sp)
    375e:	74a6                	ld	s1,104(sp)
    3760:	7906                	ld	s2,96(sp)
    3762:	69e6                	ld	s3,88(sp)
    3764:	6a46                	ld	s4,80(sp)
    3766:	6aa6                	ld	s5,72(sp)
    3768:	6b06                	ld	s6,64(sp)
    376a:	7be2                	ld	s7,56(sp)
    376c:	7c42                	ld	s8,48(sp)
    376e:	7ca2                	ld	s9,40(sp)
    3770:	7d02                	ld	s10,32(sp)
    3772:	6de2                	ld	s11,24(sp)
    3774:	6109                	addi	sp,sp,128
    3776:	8082                	ret

0000000000003778 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    3778:	715d                	addi	sp,sp,-80
    377a:	ec06                	sd	ra,24(sp)
    377c:	e822                	sd	s0,16(sp)
    377e:	1000                	addi	s0,sp,32
    3780:	e010                	sd	a2,0(s0)
    3782:	e414                	sd	a3,8(s0)
    3784:	e818                	sd	a4,16(s0)
    3786:	ec1c                	sd	a5,24(s0)
    3788:	03043023          	sd	a6,32(s0)
    378c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    3790:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    3794:	8622                	mv	a2,s0
    3796:	00000097          	auipc	ra,0x0
    379a:	e04080e7          	jalr	-508(ra) # 359a <vprintf>
}
    379e:	60e2                	ld	ra,24(sp)
    37a0:	6442                	ld	s0,16(sp)
    37a2:	6161                	addi	sp,sp,80
    37a4:	8082                	ret

00000000000037a6 <printf>:

void
printf(const char *fmt, ...)
{
    37a6:	711d                	addi	sp,sp,-96
    37a8:	ec06                	sd	ra,24(sp)
    37aa:	e822                	sd	s0,16(sp)
    37ac:	1000                	addi	s0,sp,32
    37ae:	e40c                	sd	a1,8(s0)
    37b0:	e810                	sd	a2,16(s0)
    37b2:	ec14                	sd	a3,24(s0)
    37b4:	f018                	sd	a4,32(s0)
    37b6:	f41c                	sd	a5,40(s0)
    37b8:	03043823          	sd	a6,48(s0)
    37bc:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    37c0:	00840613          	addi	a2,s0,8
    37c4:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    37c8:	85aa                	mv	a1,a0
    37ca:	4505                	li	a0,1
    37cc:	00000097          	auipc	ra,0x0
    37d0:	dce080e7          	jalr	-562(ra) # 359a <vprintf>
}
    37d4:	60e2                	ld	ra,24(sp)
    37d6:	6442                	ld	s0,16(sp)
    37d8:	6125                	addi	sp,sp,96
    37da:	8082                	ret

00000000000037dc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    37dc:	1141                	addi	sp,sp,-16
    37de:	e422                	sd	s0,8(sp)
    37e0:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    37e2:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    37e6:	00001797          	auipc	a5,0x1
    37ea:	81a7b783          	ld	a5,-2022(a5) # 4000 <freep>
    37ee:	a805                	j	381e <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    37f0:	4618                	lw	a4,8(a2)
    37f2:	9db9                	addw	a1,a1,a4
    37f4:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    37f8:	6398                	ld	a4,0(a5)
    37fa:	6318                	ld	a4,0(a4)
    37fc:	fee53823          	sd	a4,-16(a0)
    3800:	a091                	j	3844 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    3802:	ff852703          	lw	a4,-8(a0)
    3806:	9e39                	addw	a2,a2,a4
    3808:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    380a:	ff053703          	ld	a4,-16(a0)
    380e:	e398                	sd	a4,0(a5)
    3810:	a099                	j	3856 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3812:	6398                	ld	a4,0(a5)
    3814:	00e7e463          	bltu	a5,a4,381c <free+0x40>
    3818:	00e6ea63          	bltu	a3,a4,382c <free+0x50>
{
    381c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    381e:	fed7fae3          	bgeu	a5,a3,3812 <free+0x36>
    3822:	6398                	ld	a4,0(a5)
    3824:	00e6e463          	bltu	a3,a4,382c <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3828:	fee7eae3          	bltu	a5,a4,381c <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    382c:	ff852583          	lw	a1,-8(a0)
    3830:	6390                	ld	a2,0(a5)
    3832:	02059713          	slli	a4,a1,0x20
    3836:	9301                	srli	a4,a4,0x20
    3838:	0712                	slli	a4,a4,0x4
    383a:	9736                	add	a4,a4,a3
    383c:	fae60ae3          	beq	a2,a4,37f0 <free+0x14>
    bp->s.ptr = p->s.ptr;
    3840:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    3844:	4790                	lw	a2,8(a5)
    3846:	02061713          	slli	a4,a2,0x20
    384a:	9301                	srli	a4,a4,0x20
    384c:	0712                	slli	a4,a4,0x4
    384e:	973e                	add	a4,a4,a5
    3850:	fae689e3          	beq	a3,a4,3802 <free+0x26>
  } else
    p->s.ptr = bp;
    3854:	e394                	sd	a3,0(a5)
  freep = p;
    3856:	00000717          	auipc	a4,0x0
    385a:	7af73523          	sd	a5,1962(a4) # 4000 <freep>
}
    385e:	6422                	ld	s0,8(sp)
    3860:	0141                	addi	sp,sp,16
    3862:	8082                	ret

0000000000003864 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3864:	7139                	addi	sp,sp,-64
    3866:	fc06                	sd	ra,56(sp)
    3868:	f822                	sd	s0,48(sp)
    386a:	f426                	sd	s1,40(sp)
    386c:	f04a                	sd	s2,32(sp)
    386e:	ec4e                	sd	s3,24(sp)
    3870:	e852                	sd	s4,16(sp)
    3872:	e456                	sd	s5,8(sp)
    3874:	e05a                	sd	s6,0(sp)
    3876:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3878:	02051493          	slli	s1,a0,0x20
    387c:	9081                	srli	s1,s1,0x20
    387e:	04bd                	addi	s1,s1,15
    3880:	8091                	srli	s1,s1,0x4
    3882:	0014899b          	addiw	s3,s1,1
    3886:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    3888:	00000517          	auipc	a0,0x0
    388c:	77853503          	ld	a0,1912(a0) # 4000 <freep>
    3890:	c515                	beqz	a0,38bc <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3892:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3894:	4798                	lw	a4,8(a5)
    3896:	02977f63          	bgeu	a4,s1,38d4 <malloc+0x70>
    389a:	8a4e                	mv	s4,s3
    389c:	0009871b          	sext.w	a4,s3
    38a0:	6685                	lui	a3,0x1
    38a2:	00d77363          	bgeu	a4,a3,38a8 <malloc+0x44>
    38a6:	6a05                	lui	s4,0x1
    38a8:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    38ac:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    38b0:	00000917          	auipc	s2,0x0
    38b4:	75090913          	addi	s2,s2,1872 # 4000 <freep>
  if(p == (char*)-1)
    38b8:	5afd                	li	s5,-1
    38ba:	a88d                	j	392c <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    38bc:	00001797          	auipc	a5,0x1
    38c0:	95478793          	addi	a5,a5,-1708 # 4210 <base>
    38c4:	00000717          	auipc	a4,0x0
    38c8:	72f73e23          	sd	a5,1852(a4) # 4000 <freep>
    38cc:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    38ce:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    38d2:	b7e1                	j	389a <malloc+0x36>
      if(p->s.size == nunits)
    38d4:	02e48b63          	beq	s1,a4,390a <malloc+0xa6>
        p->s.size -= nunits;
    38d8:	4137073b          	subw	a4,a4,s3
    38dc:	c798                	sw	a4,8(a5)
        p += p->s.size;
    38de:	1702                	slli	a4,a4,0x20
    38e0:	9301                	srli	a4,a4,0x20
    38e2:	0712                	slli	a4,a4,0x4
    38e4:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    38e6:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    38ea:	00000717          	auipc	a4,0x0
    38ee:	70a73b23          	sd	a0,1814(a4) # 4000 <freep>
      return (void*)(p + 1);
    38f2:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    38f6:	70e2                	ld	ra,56(sp)
    38f8:	7442                	ld	s0,48(sp)
    38fa:	74a2                	ld	s1,40(sp)
    38fc:	7902                	ld	s2,32(sp)
    38fe:	69e2                	ld	s3,24(sp)
    3900:	6a42                	ld	s4,16(sp)
    3902:	6aa2                	ld	s5,8(sp)
    3904:	6b02                	ld	s6,0(sp)
    3906:	6121                	addi	sp,sp,64
    3908:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    390a:	6398                	ld	a4,0(a5)
    390c:	e118                	sd	a4,0(a0)
    390e:	bff1                	j	38ea <malloc+0x86>
  hp->s.size = nu;
    3910:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    3914:	0541                	addi	a0,a0,16
    3916:	00000097          	auipc	ra,0x0
    391a:	ec6080e7          	jalr	-314(ra) # 37dc <free>
  return freep;
    391e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    3922:	d971                	beqz	a0,38f6 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3924:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3926:	4798                	lw	a4,8(a5)
    3928:	fa9776e3          	bgeu	a4,s1,38d4 <malloc+0x70>
    if(p == freep)
    392c:	00093703          	ld	a4,0(s2)
    3930:	853e                	mv	a0,a5
    3932:	fef719e3          	bne	a4,a5,3924 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3936:	8552                	mv	a0,s4
    3938:	00000097          	auipc	ra,0x0
    393c:	b56080e7          	jalr	-1194(ra) # 348e <sbrk>
  if(p == (char*)-1)
    3940:	fd5518e3          	bne	a0,s5,3910 <malloc+0xac>
        return 0;
    3944:	4501                	li	a0,0
    3946:	bf45                	j	38f6 <malloc+0x92>
