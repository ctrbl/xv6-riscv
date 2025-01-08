
user/_wc:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
    3000:	7119                	addi	sp,sp,-128
    3002:	fc86                	sd	ra,120(sp)
    3004:	f8a2                	sd	s0,112(sp)
    3006:	f4a6                	sd	s1,104(sp)
    3008:	f0ca                	sd	s2,96(sp)
    300a:	ecce                	sd	s3,88(sp)
    300c:	e8d2                	sd	s4,80(sp)
    300e:	e4d6                	sd	s5,72(sp)
    3010:	e0da                	sd	s6,64(sp)
    3012:	fc5e                	sd	s7,56(sp)
    3014:	f862                	sd	s8,48(sp)
    3016:	f466                	sd	s9,40(sp)
    3018:	f06a                	sd	s10,32(sp)
    301a:	ec6e                	sd	s11,24(sp)
    301c:	0100                	addi	s0,sp,128
    301e:	f8a43423          	sd	a0,-120(s0)
    3022:	f8b43023          	sd	a1,-128(s0)
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
    3026:	4981                	li	s3,0
  l = w = c = 0;
    3028:	4c81                	li	s9,0
    302a:	4c01                	li	s8,0
    302c:	4b81                	li	s7,0
    302e:	00001d97          	auipc	s11,0x1
    3032:	fe3d8d93          	addi	s11,s11,-29 # 4011 <buf+0x1>
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i=0; i<n; i++){
      c++;
      if(buf[i] == '\n')
    3036:	4aa9                	li	s5,10
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
    3038:	00001a17          	auipc	s4,0x1
    303c:	988a0a13          	addi	s4,s4,-1656 # 39c0 <malloc+0xe4>
        inword = 0;
    3040:	4b01                	li	s6,0
  while((n = read(fd, buf, sizeof(buf))) > 0){
    3042:	a805                	j	3072 <wc+0x72>
      if(strchr(" \r\t\n\v", buf[i]))
    3044:	8552                	mv	a0,s4
    3046:	00000097          	auipc	ra,0x0
    304a:	1fe080e7          	jalr	510(ra) # 3244 <strchr>
    304e:	c919                	beqz	a0,3064 <wc+0x64>
        inword = 0;
    3050:	89da                	mv	s3,s6
    for(i=0; i<n; i++){
    3052:	0485                	addi	s1,s1,1
    3054:	01248d63          	beq	s1,s2,306e <wc+0x6e>
      if(buf[i] == '\n')
    3058:	0004c583          	lbu	a1,0(s1)
    305c:	ff5594e3          	bne	a1,s5,3044 <wc+0x44>
        l++;
    3060:	2b85                	addiw	s7,s7,1
    3062:	b7cd                	j	3044 <wc+0x44>
      else if(!inword){
    3064:	fe0997e3          	bnez	s3,3052 <wc+0x52>
        w++;
    3068:	2c05                	addiw	s8,s8,1
        inword = 1;
    306a:	4985                	li	s3,1
    306c:	b7dd                	j	3052 <wc+0x52>
      c++;
    306e:	01ac8cbb          	addw	s9,s9,s10
  while((n = read(fd, buf, sizeof(buf))) > 0){
    3072:	20000613          	li	a2,512
    3076:	00001597          	auipc	a1,0x1
    307a:	f9a58593          	addi	a1,a1,-102 # 4010 <buf>
    307e:	f8843503          	ld	a0,-120(s0)
    3082:	00000097          	auipc	ra,0x0
    3086:	414080e7          	jalr	1044(ra) # 3496 <read>
    308a:	00a05f63          	blez	a0,30a8 <wc+0xa8>
    for(i=0; i<n; i++){
    308e:	00001497          	auipc	s1,0x1
    3092:	f8248493          	addi	s1,s1,-126 # 4010 <buf>
    3096:	00050d1b          	sext.w	s10,a0
    309a:	fff5091b          	addiw	s2,a0,-1
    309e:	1902                	slli	s2,s2,0x20
    30a0:	02095913          	srli	s2,s2,0x20
    30a4:	996e                	add	s2,s2,s11
    30a6:	bf4d                	j	3058 <wc+0x58>
      }
    }
  }
  if(n < 0){
    30a8:	02054e63          	bltz	a0,30e4 <wc+0xe4>
    printf("wc: read error\n");
    exit(1);
  }
  printf("%d %d %d %s\n", l, w, c, name);
    30ac:	f8043703          	ld	a4,-128(s0)
    30b0:	86e6                	mv	a3,s9
    30b2:	8662                	mv	a2,s8
    30b4:	85de                	mv	a1,s7
    30b6:	00001517          	auipc	a0,0x1
    30ba:	92250513          	addi	a0,a0,-1758 # 39d8 <malloc+0xfc>
    30be:	00000097          	auipc	ra,0x0
    30c2:	760080e7          	jalr	1888(ra) # 381e <printf>
}
    30c6:	70e6                	ld	ra,120(sp)
    30c8:	7446                	ld	s0,112(sp)
    30ca:	74a6                	ld	s1,104(sp)
    30cc:	7906                	ld	s2,96(sp)
    30ce:	69e6                	ld	s3,88(sp)
    30d0:	6a46                	ld	s4,80(sp)
    30d2:	6aa6                	ld	s5,72(sp)
    30d4:	6b06                	ld	s6,64(sp)
    30d6:	7be2                	ld	s7,56(sp)
    30d8:	7c42                	ld	s8,48(sp)
    30da:	7ca2                	ld	s9,40(sp)
    30dc:	7d02                	ld	s10,32(sp)
    30de:	6de2                	ld	s11,24(sp)
    30e0:	6109                	addi	sp,sp,128
    30e2:	8082                	ret
    printf("wc: read error\n");
    30e4:	00001517          	auipc	a0,0x1
    30e8:	8e450513          	addi	a0,a0,-1820 # 39c8 <malloc+0xec>
    30ec:	00000097          	auipc	ra,0x0
    30f0:	732080e7          	jalr	1842(ra) # 381e <printf>
    exit(1);
    30f4:	4505                	li	a0,1
    30f6:	00000097          	auipc	ra,0x0
    30fa:	380080e7          	jalr	896(ra) # 3476 <exit>

00000000000030fe <main>:

int
main(int argc, char *argv[])
{
    30fe:	7179                	addi	sp,sp,-48
    3100:	f406                	sd	ra,40(sp)
    3102:	f022                	sd	s0,32(sp)
    3104:	ec26                	sd	s1,24(sp)
    3106:	e84a                	sd	s2,16(sp)
    3108:	e44e                	sd	s3,8(sp)
    310a:	e052                	sd	s4,0(sp)
    310c:	1800                	addi	s0,sp,48
  int fd, i;

  if(argc <= 1){
    310e:	4785                	li	a5,1
    3110:	04a7d763          	bge	a5,a0,315e <main+0x60>
    3114:	00858493          	addi	s1,a1,8
    3118:	ffe5099b          	addiw	s3,a0,-2
    311c:	1982                	slli	s3,s3,0x20
    311e:	0209d993          	srli	s3,s3,0x20
    3122:	098e                	slli	s3,s3,0x3
    3124:	05c1                	addi	a1,a1,16
    3126:	99ae                	add	s3,s3,a1
    wc(0, "");
    exit(0);
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
    3128:	4581                	li	a1,0
    312a:	6088                	ld	a0,0(s1)
    312c:	00000097          	auipc	ra,0x0
    3130:	392080e7          	jalr	914(ra) # 34be <open>
    3134:	892a                	mv	s2,a0
    3136:	04054263          	bltz	a0,317a <main+0x7c>
      printf("wc: cannot open %s\n", argv[i]);
      exit(1);
    }
    wc(fd, argv[i]);
    313a:	608c                	ld	a1,0(s1)
    313c:	00000097          	auipc	ra,0x0
    3140:	ec4080e7          	jalr	-316(ra) # 3000 <wc>
    close(fd);
    3144:	854a                	mv	a0,s2
    3146:	00000097          	auipc	ra,0x0
    314a:	360080e7          	jalr	864(ra) # 34a6 <close>
  for(i = 1; i < argc; i++){
    314e:	04a1                	addi	s1,s1,8
    3150:	fd349ce3          	bne	s1,s3,3128 <main+0x2a>
  }
  exit(0);
    3154:	4501                	li	a0,0
    3156:	00000097          	auipc	ra,0x0
    315a:	320080e7          	jalr	800(ra) # 3476 <exit>
    wc(0, "");
    315e:	00001597          	auipc	a1,0x1
    3162:	88a58593          	addi	a1,a1,-1910 # 39e8 <malloc+0x10c>
    3166:	4501                	li	a0,0
    3168:	00000097          	auipc	ra,0x0
    316c:	e98080e7          	jalr	-360(ra) # 3000 <wc>
    exit(0);
    3170:	4501                	li	a0,0
    3172:	00000097          	auipc	ra,0x0
    3176:	304080e7          	jalr	772(ra) # 3476 <exit>
      printf("wc: cannot open %s\n", argv[i]);
    317a:	608c                	ld	a1,0(s1)
    317c:	00001517          	auipc	a0,0x1
    3180:	87450513          	addi	a0,a0,-1932 # 39f0 <malloc+0x114>
    3184:	00000097          	auipc	ra,0x0
    3188:	69a080e7          	jalr	1690(ra) # 381e <printf>
      exit(1);
    318c:	4505                	li	a0,1
    318e:	00000097          	auipc	ra,0x0
    3192:	2e8080e7          	jalr	744(ra) # 3476 <exit>

0000000000003196 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    3196:	1141                	addi	sp,sp,-16
    3198:	e406                	sd	ra,8(sp)
    319a:	e022                	sd	s0,0(sp)
    319c:	0800                	addi	s0,sp,16
  extern int main();
  main();
    319e:	00000097          	auipc	ra,0x0
    31a2:	f60080e7          	jalr	-160(ra) # 30fe <main>
  exit(0);
    31a6:	4501                	li	a0,0
    31a8:	00000097          	auipc	ra,0x0
    31ac:	2ce080e7          	jalr	718(ra) # 3476 <exit>

00000000000031b0 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    31b0:	1141                	addi	sp,sp,-16
    31b2:	e422                	sd	s0,8(sp)
    31b4:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    31b6:	87aa                	mv	a5,a0
    31b8:	0585                	addi	a1,a1,1
    31ba:	0785                	addi	a5,a5,1
    31bc:	fff5c703          	lbu	a4,-1(a1)
    31c0:	fee78fa3          	sb	a4,-1(a5)
    31c4:	fb75                	bnez	a4,31b8 <strcpy+0x8>
    ;
  return os;
}
    31c6:	6422                	ld	s0,8(sp)
    31c8:	0141                	addi	sp,sp,16
    31ca:	8082                	ret

00000000000031cc <strcmp>:

int
strcmp(const char *p, const char *q)
{
    31cc:	1141                	addi	sp,sp,-16
    31ce:	e422                	sd	s0,8(sp)
    31d0:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    31d2:	00054783          	lbu	a5,0(a0)
    31d6:	cb91                	beqz	a5,31ea <strcmp+0x1e>
    31d8:	0005c703          	lbu	a4,0(a1)
    31dc:	00f71763          	bne	a4,a5,31ea <strcmp+0x1e>
    p++, q++;
    31e0:	0505                	addi	a0,a0,1
    31e2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    31e4:	00054783          	lbu	a5,0(a0)
    31e8:	fbe5                	bnez	a5,31d8 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    31ea:	0005c503          	lbu	a0,0(a1)
}
    31ee:	40a7853b          	subw	a0,a5,a0
    31f2:	6422                	ld	s0,8(sp)
    31f4:	0141                	addi	sp,sp,16
    31f6:	8082                	ret

00000000000031f8 <strlen>:

uint
strlen(const char *s)
{
    31f8:	1141                	addi	sp,sp,-16
    31fa:	e422                	sd	s0,8(sp)
    31fc:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    31fe:	00054783          	lbu	a5,0(a0)
    3202:	cf91                	beqz	a5,321e <strlen+0x26>
    3204:	0505                	addi	a0,a0,1
    3206:	87aa                	mv	a5,a0
    3208:	4685                	li	a3,1
    320a:	9e89                	subw	a3,a3,a0
    320c:	00f6853b          	addw	a0,a3,a5
    3210:	0785                	addi	a5,a5,1
    3212:	fff7c703          	lbu	a4,-1(a5)
    3216:	fb7d                	bnez	a4,320c <strlen+0x14>
    ;
  return n;
}
    3218:	6422                	ld	s0,8(sp)
    321a:	0141                	addi	sp,sp,16
    321c:	8082                	ret
  for(n = 0; s[n]; n++)
    321e:	4501                	li	a0,0
    3220:	bfe5                	j	3218 <strlen+0x20>

0000000000003222 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3222:	1141                	addi	sp,sp,-16
    3224:	e422                	sd	s0,8(sp)
    3226:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    3228:	ca19                	beqz	a2,323e <memset+0x1c>
    322a:	87aa                	mv	a5,a0
    322c:	1602                	slli	a2,a2,0x20
    322e:	9201                	srli	a2,a2,0x20
    3230:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    3234:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    3238:	0785                	addi	a5,a5,1
    323a:	fee79de3          	bne	a5,a4,3234 <memset+0x12>
  }
  return dst;
}
    323e:	6422                	ld	s0,8(sp)
    3240:	0141                	addi	sp,sp,16
    3242:	8082                	ret

0000000000003244 <strchr>:

char*
strchr(const char *s, char c)
{
    3244:	1141                	addi	sp,sp,-16
    3246:	e422                	sd	s0,8(sp)
    3248:	0800                	addi	s0,sp,16
  for(; *s; s++)
    324a:	00054783          	lbu	a5,0(a0)
    324e:	cb99                	beqz	a5,3264 <strchr+0x20>
    if(*s == c)
    3250:	00f58763          	beq	a1,a5,325e <strchr+0x1a>
  for(; *s; s++)
    3254:	0505                	addi	a0,a0,1
    3256:	00054783          	lbu	a5,0(a0)
    325a:	fbfd                	bnez	a5,3250 <strchr+0xc>
      return (char*)s;
  return 0;
    325c:	4501                	li	a0,0
}
    325e:	6422                	ld	s0,8(sp)
    3260:	0141                	addi	sp,sp,16
    3262:	8082                	ret
  return 0;
    3264:	4501                	li	a0,0
    3266:	bfe5                	j	325e <strchr+0x1a>

0000000000003268 <gets>:

char*
gets(char *buf, int max)
{
    3268:	711d                	addi	sp,sp,-96
    326a:	ec86                	sd	ra,88(sp)
    326c:	e8a2                	sd	s0,80(sp)
    326e:	e4a6                	sd	s1,72(sp)
    3270:	e0ca                	sd	s2,64(sp)
    3272:	fc4e                	sd	s3,56(sp)
    3274:	f852                	sd	s4,48(sp)
    3276:	f456                	sd	s5,40(sp)
    3278:	f05a                	sd	s6,32(sp)
    327a:	ec5e                	sd	s7,24(sp)
    327c:	1080                	addi	s0,sp,96
    327e:	8baa                	mv	s7,a0
    3280:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3282:	892a                	mv	s2,a0
    3284:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    3286:	4aa9                	li	s5,10
    3288:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    328a:	89a6                	mv	s3,s1
    328c:	2485                	addiw	s1,s1,1
    328e:	0344d863          	bge	s1,s4,32be <gets+0x56>
    cc = read(0, &c, 1);
    3292:	4605                	li	a2,1
    3294:	faf40593          	addi	a1,s0,-81
    3298:	4501                	li	a0,0
    329a:	00000097          	auipc	ra,0x0
    329e:	1fc080e7          	jalr	508(ra) # 3496 <read>
    if(cc < 1)
    32a2:	00a05e63          	blez	a0,32be <gets+0x56>
    buf[i++] = c;
    32a6:	faf44783          	lbu	a5,-81(s0)
    32aa:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    32ae:	01578763          	beq	a5,s5,32bc <gets+0x54>
    32b2:	0905                	addi	s2,s2,1
    32b4:	fd679be3          	bne	a5,s6,328a <gets+0x22>
  for(i=0; i+1 < max; ){
    32b8:	89a6                	mv	s3,s1
    32ba:	a011                	j	32be <gets+0x56>
    32bc:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    32be:	99de                	add	s3,s3,s7
    32c0:	00098023          	sb	zero,0(s3)
  return buf;
}
    32c4:	855e                	mv	a0,s7
    32c6:	60e6                	ld	ra,88(sp)
    32c8:	6446                	ld	s0,80(sp)
    32ca:	64a6                	ld	s1,72(sp)
    32cc:	6906                	ld	s2,64(sp)
    32ce:	79e2                	ld	s3,56(sp)
    32d0:	7a42                	ld	s4,48(sp)
    32d2:	7aa2                	ld	s5,40(sp)
    32d4:	7b02                	ld	s6,32(sp)
    32d6:	6be2                	ld	s7,24(sp)
    32d8:	6125                	addi	sp,sp,96
    32da:	8082                	ret

00000000000032dc <stat>:

int
stat(const char *n, struct stat *st)
{
    32dc:	1101                	addi	sp,sp,-32
    32de:	ec06                	sd	ra,24(sp)
    32e0:	e822                	sd	s0,16(sp)
    32e2:	e426                	sd	s1,8(sp)
    32e4:	e04a                	sd	s2,0(sp)
    32e6:	1000                	addi	s0,sp,32
    32e8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    32ea:	4581                	li	a1,0
    32ec:	00000097          	auipc	ra,0x0
    32f0:	1d2080e7          	jalr	466(ra) # 34be <open>
  if(fd < 0)
    32f4:	02054563          	bltz	a0,331e <stat+0x42>
    32f8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    32fa:	85ca                	mv	a1,s2
    32fc:	00000097          	auipc	ra,0x0
    3300:	1da080e7          	jalr	474(ra) # 34d6 <fstat>
    3304:	892a                	mv	s2,a0
  close(fd);
    3306:	8526                	mv	a0,s1
    3308:	00000097          	auipc	ra,0x0
    330c:	19e080e7          	jalr	414(ra) # 34a6 <close>
  return r;
}
    3310:	854a                	mv	a0,s2
    3312:	60e2                	ld	ra,24(sp)
    3314:	6442                	ld	s0,16(sp)
    3316:	64a2                	ld	s1,8(sp)
    3318:	6902                	ld	s2,0(sp)
    331a:	6105                	addi	sp,sp,32
    331c:	8082                	ret
    return -1;
    331e:	597d                	li	s2,-1
    3320:	bfc5                	j	3310 <stat+0x34>

0000000000003322 <atoi>:

int
atoi(const char *s)
{
    3322:	1141                	addi	sp,sp,-16
    3324:	e422                	sd	s0,8(sp)
    3326:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3328:	00054603          	lbu	a2,0(a0)
    332c:	fd06079b          	addiw	a5,a2,-48
    3330:	0ff7f793          	andi	a5,a5,255
    3334:	4725                	li	a4,9
    3336:	02f76963          	bltu	a4,a5,3368 <atoi+0x46>
    333a:	86aa                	mv	a3,a0
  n = 0;
    333c:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    333e:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    3340:	0685                	addi	a3,a3,1
    3342:	0025179b          	slliw	a5,a0,0x2
    3346:	9fa9                	addw	a5,a5,a0
    3348:	0017979b          	slliw	a5,a5,0x1
    334c:	9fb1                	addw	a5,a5,a2
    334e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    3352:	0006c603          	lbu	a2,0(a3)
    3356:	fd06071b          	addiw	a4,a2,-48
    335a:	0ff77713          	andi	a4,a4,255
    335e:	fee5f1e3          	bgeu	a1,a4,3340 <atoi+0x1e>
  return n;
}
    3362:	6422                	ld	s0,8(sp)
    3364:	0141                	addi	sp,sp,16
    3366:	8082                	ret
  n = 0;
    3368:	4501                	li	a0,0
    336a:	bfe5                	j	3362 <atoi+0x40>

000000000000336c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    336c:	1141                	addi	sp,sp,-16
    336e:	e422                	sd	s0,8(sp)
    3370:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    3372:	02b57463          	bgeu	a0,a1,339a <memmove+0x2e>
    while(n-- > 0)
    3376:	00c05f63          	blez	a2,3394 <memmove+0x28>
    337a:	1602                	slli	a2,a2,0x20
    337c:	9201                	srli	a2,a2,0x20
    337e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    3382:	872a                	mv	a4,a0
      *dst++ = *src++;
    3384:	0585                	addi	a1,a1,1
    3386:	0705                	addi	a4,a4,1
    3388:	fff5c683          	lbu	a3,-1(a1)
    338c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    3390:	fee79ae3          	bne	a5,a4,3384 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    3394:	6422                	ld	s0,8(sp)
    3396:	0141                	addi	sp,sp,16
    3398:	8082                	ret
    dst += n;
    339a:	00c50733          	add	a4,a0,a2
    src += n;
    339e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    33a0:	fec05ae3          	blez	a2,3394 <memmove+0x28>
    33a4:	fff6079b          	addiw	a5,a2,-1
    33a8:	1782                	slli	a5,a5,0x20
    33aa:	9381                	srli	a5,a5,0x20
    33ac:	fff7c793          	not	a5,a5
    33b0:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    33b2:	15fd                	addi	a1,a1,-1
    33b4:	177d                	addi	a4,a4,-1
    33b6:	0005c683          	lbu	a3,0(a1)
    33ba:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    33be:	fee79ae3          	bne	a5,a4,33b2 <memmove+0x46>
    33c2:	bfc9                	j	3394 <memmove+0x28>

00000000000033c4 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    33c4:	1141                	addi	sp,sp,-16
    33c6:	e422                	sd	s0,8(sp)
    33c8:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    33ca:	ca05                	beqz	a2,33fa <memcmp+0x36>
    33cc:	fff6069b          	addiw	a3,a2,-1
    33d0:	1682                	slli	a3,a3,0x20
    33d2:	9281                	srli	a3,a3,0x20
    33d4:	0685                	addi	a3,a3,1
    33d6:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    33d8:	00054783          	lbu	a5,0(a0)
    33dc:	0005c703          	lbu	a4,0(a1)
    33e0:	00e79863          	bne	a5,a4,33f0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    33e4:	0505                	addi	a0,a0,1
    p2++;
    33e6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    33e8:	fed518e3          	bne	a0,a3,33d8 <memcmp+0x14>
  }
  return 0;
    33ec:	4501                	li	a0,0
    33ee:	a019                	j	33f4 <memcmp+0x30>
      return *p1 - *p2;
    33f0:	40e7853b          	subw	a0,a5,a4
}
    33f4:	6422                	ld	s0,8(sp)
    33f6:	0141                	addi	sp,sp,16
    33f8:	8082                	ret
  return 0;
    33fa:	4501                	li	a0,0
    33fc:	bfe5                	j	33f4 <memcmp+0x30>

00000000000033fe <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    33fe:	1141                	addi	sp,sp,-16
    3400:	e406                	sd	ra,8(sp)
    3402:	e022                	sd	s0,0(sp)
    3404:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    3406:	00000097          	auipc	ra,0x0
    340a:	f66080e7          	jalr	-154(ra) # 336c <memmove>
}
    340e:	60a2                	ld	ra,8(sp)
    3410:	6402                	ld	s0,0(sp)
    3412:	0141                	addi	sp,sp,16
    3414:	8082                	ret

0000000000003416 <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    3416:	1141                	addi	sp,sp,-16
    3418:	e422                	sd	s0,8(sp)
    341a:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    341c:	00052023          	sw	zero,0(a0)
}  
    3420:	6422                	ld	s0,8(sp)
    3422:	0141                	addi	sp,sp,16
    3424:	8082                	ret

0000000000003426 <lock>:

void lock(struct spinlock * lk) 
{    
    3426:	1141                	addi	sp,sp,-16
    3428:	e422                	sd	s0,8(sp)
    342a:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    342c:	4705                	li	a4,1
    342e:	87ba                	mv	a5,a4
    3430:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    3434:	2781                	sext.w	a5,a5
    3436:	ffe5                	bnez	a5,342e <lock+0x8>
}  
    3438:	6422                	ld	s0,8(sp)
    343a:	0141                	addi	sp,sp,16
    343c:	8082                	ret

000000000000343e <unlock>:

void unlock(struct spinlock * lk) 
{   
    343e:	1141                	addi	sp,sp,-16
    3440:	e422                	sd	s0,8(sp)
    3442:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    3444:	0f50000f          	fence	iorw,ow
    3448:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    344c:	6422                	ld	s0,8(sp)
    344e:	0141                	addi	sp,sp,16
    3450:	8082                	ret

0000000000003452 <isDigit>:

unsigned int isDigit(char *c) {
    3452:	1141                	addi	sp,sp,-16
    3454:	e422                	sd	s0,8(sp)
    3456:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    3458:	00054503          	lbu	a0,0(a0)
    345c:	fd05051b          	addiw	a0,a0,-48
    3460:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    3464:	00a53513          	sltiu	a0,a0,10
    3468:	6422                	ld	s0,8(sp)
    346a:	0141                	addi	sp,sp,16
    346c:	8082                	ret

000000000000346e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    346e:	4885                	li	a7,1
 ecall
    3470:	00000073          	ecall
 ret
    3474:	8082                	ret

0000000000003476 <exit>:
.global exit
exit:
 li a7, SYS_exit
    3476:	4889                	li	a7,2
 ecall
    3478:	00000073          	ecall
 ret
    347c:	8082                	ret

000000000000347e <wait>:
.global wait
wait:
 li a7, SYS_wait
    347e:	488d                	li	a7,3
 ecall
    3480:	00000073          	ecall
 ret
    3484:	8082                	ret

0000000000003486 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    3486:	48e1                	li	a7,24
 ecall
    3488:	00000073          	ecall
 ret
    348c:	8082                	ret

000000000000348e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    348e:	4891                	li	a7,4
 ecall
    3490:	00000073          	ecall
 ret
    3494:	8082                	ret

0000000000003496 <read>:
.global read
read:
 li a7, SYS_read
    3496:	4895                	li	a7,5
 ecall
    3498:	00000073          	ecall
 ret
    349c:	8082                	ret

000000000000349e <write>:
.global write
write:
 li a7, SYS_write
    349e:	48c1                	li	a7,16
 ecall
    34a0:	00000073          	ecall
 ret
    34a4:	8082                	ret

00000000000034a6 <close>:
.global close
close:
 li a7, SYS_close
    34a6:	48d5                	li	a7,21
 ecall
    34a8:	00000073          	ecall
 ret
    34ac:	8082                	ret

00000000000034ae <kill>:
.global kill
kill:
 li a7, SYS_kill
    34ae:	4899                	li	a7,6
 ecall
    34b0:	00000073          	ecall
 ret
    34b4:	8082                	ret

00000000000034b6 <exec>:
.global exec
exec:
 li a7, SYS_exec
    34b6:	489d                	li	a7,7
 ecall
    34b8:	00000073          	ecall
 ret
    34bc:	8082                	ret

00000000000034be <open>:
.global open
open:
 li a7, SYS_open
    34be:	48bd                	li	a7,15
 ecall
    34c0:	00000073          	ecall
 ret
    34c4:	8082                	ret

00000000000034c6 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    34c6:	48c5                	li	a7,17
 ecall
    34c8:	00000073          	ecall
 ret
    34cc:	8082                	ret

00000000000034ce <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    34ce:	48c9                	li	a7,18
 ecall
    34d0:	00000073          	ecall
 ret
    34d4:	8082                	ret

00000000000034d6 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    34d6:	48a1                	li	a7,8
 ecall
    34d8:	00000073          	ecall
 ret
    34dc:	8082                	ret

00000000000034de <link>:
.global link
link:
 li a7, SYS_link
    34de:	48cd                	li	a7,19
 ecall
    34e0:	00000073          	ecall
 ret
    34e4:	8082                	ret

00000000000034e6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    34e6:	48d1                	li	a7,20
 ecall
    34e8:	00000073          	ecall
 ret
    34ec:	8082                	ret

00000000000034ee <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    34ee:	48a5                	li	a7,9
 ecall
    34f0:	00000073          	ecall
 ret
    34f4:	8082                	ret

00000000000034f6 <dup>:
.global dup
dup:
 li a7, SYS_dup
    34f6:	48a9                	li	a7,10
 ecall
    34f8:	00000073          	ecall
 ret
    34fc:	8082                	ret

00000000000034fe <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    34fe:	48ad                	li	a7,11
 ecall
    3500:	00000073          	ecall
 ret
    3504:	8082                	ret

0000000000003506 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    3506:	48b1                	li	a7,12
 ecall
    3508:	00000073          	ecall
 ret
    350c:	8082                	ret

000000000000350e <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    350e:	48b5                	li	a7,13
 ecall
    3510:	00000073          	ecall
 ret
    3514:	8082                	ret

0000000000003516 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    3516:	48b9                	li	a7,14
 ecall
    3518:	00000073          	ecall
 ret
    351c:	8082                	ret

000000000000351e <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    351e:	48d9                	li	a7,22
 ecall
    3520:	00000073          	ecall
 ret
    3524:	8082                	ret

0000000000003526 <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    3526:	48dd                	li	a7,23
 ecall
    3528:	00000073          	ecall
 ret
    352c:	8082                	ret

000000000000352e <ps>:
.global ps
ps:
 li a7, SYS_ps
    352e:	48e5                	li	a7,25
 ecall
    3530:	00000073          	ecall
 ret
    3534:	8082                	ret

0000000000003536 <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    3536:	48e9                	li	a7,26
 ecall
    3538:	00000073          	ecall
 ret
    353c:	8082                	ret

000000000000353e <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    353e:	48ed                	li	a7,27
 ecall
    3540:	00000073          	ecall
 ret
    3544:	8082                	ret

0000000000003546 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    3546:	1101                	addi	sp,sp,-32
    3548:	ec06                	sd	ra,24(sp)
    354a:	e822                	sd	s0,16(sp)
    354c:	1000                	addi	s0,sp,32
    354e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    3552:	4605                	li	a2,1
    3554:	fef40593          	addi	a1,s0,-17
    3558:	00000097          	auipc	ra,0x0
    355c:	f46080e7          	jalr	-186(ra) # 349e <write>
}
    3560:	60e2                	ld	ra,24(sp)
    3562:	6442                	ld	s0,16(sp)
    3564:	6105                	addi	sp,sp,32
    3566:	8082                	ret

0000000000003568 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3568:	7139                	addi	sp,sp,-64
    356a:	fc06                	sd	ra,56(sp)
    356c:	f822                	sd	s0,48(sp)
    356e:	f426                	sd	s1,40(sp)
    3570:	f04a                	sd	s2,32(sp)
    3572:	ec4e                	sd	s3,24(sp)
    3574:	0080                	addi	s0,sp,64
    3576:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3578:	c299                	beqz	a3,357e <printint+0x16>
    357a:	0805c863          	bltz	a1,360a <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    357e:	2581                	sext.w	a1,a1
  neg = 0;
    3580:	4881                	li	a7,0
    3582:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    3586:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    3588:	2601                	sext.w	a2,a2
    358a:	00000517          	auipc	a0,0x0
    358e:	48650513          	addi	a0,a0,1158 # 3a10 <digits>
    3592:	883a                	mv	a6,a4
    3594:	2705                	addiw	a4,a4,1
    3596:	02c5f7bb          	remuw	a5,a1,a2
    359a:	1782                	slli	a5,a5,0x20
    359c:	9381                	srli	a5,a5,0x20
    359e:	97aa                	add	a5,a5,a0
    35a0:	0007c783          	lbu	a5,0(a5)
    35a4:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    35a8:	0005879b          	sext.w	a5,a1
    35ac:	02c5d5bb          	divuw	a1,a1,a2
    35b0:	0685                	addi	a3,a3,1
    35b2:	fec7f0e3          	bgeu	a5,a2,3592 <printint+0x2a>
  if(neg)
    35b6:	00088b63          	beqz	a7,35cc <printint+0x64>
    buf[i++] = '-';
    35ba:	fd040793          	addi	a5,s0,-48
    35be:	973e                	add	a4,a4,a5
    35c0:	02d00793          	li	a5,45
    35c4:	fef70823          	sb	a5,-16(a4)
    35c8:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    35cc:	02e05863          	blez	a4,35fc <printint+0x94>
    35d0:	fc040793          	addi	a5,s0,-64
    35d4:	00e78933          	add	s2,a5,a4
    35d8:	fff78993          	addi	s3,a5,-1
    35dc:	99ba                	add	s3,s3,a4
    35de:	377d                	addiw	a4,a4,-1
    35e0:	1702                	slli	a4,a4,0x20
    35e2:	9301                	srli	a4,a4,0x20
    35e4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    35e8:	fff94583          	lbu	a1,-1(s2)
    35ec:	8526                	mv	a0,s1
    35ee:	00000097          	auipc	ra,0x0
    35f2:	f58080e7          	jalr	-168(ra) # 3546 <putc>
  while(--i >= 0)
    35f6:	197d                	addi	s2,s2,-1
    35f8:	ff3918e3          	bne	s2,s3,35e8 <printint+0x80>
}
    35fc:	70e2                	ld	ra,56(sp)
    35fe:	7442                	ld	s0,48(sp)
    3600:	74a2                	ld	s1,40(sp)
    3602:	7902                	ld	s2,32(sp)
    3604:	69e2                	ld	s3,24(sp)
    3606:	6121                	addi	sp,sp,64
    3608:	8082                	ret
    x = -xx;
    360a:	40b005bb          	negw	a1,a1
    neg = 1;
    360e:	4885                	li	a7,1
    x = -xx;
    3610:	bf8d                	j	3582 <printint+0x1a>

0000000000003612 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    3612:	7119                	addi	sp,sp,-128
    3614:	fc86                	sd	ra,120(sp)
    3616:	f8a2                	sd	s0,112(sp)
    3618:	f4a6                	sd	s1,104(sp)
    361a:	f0ca                	sd	s2,96(sp)
    361c:	ecce                	sd	s3,88(sp)
    361e:	e8d2                	sd	s4,80(sp)
    3620:	e4d6                	sd	s5,72(sp)
    3622:	e0da                	sd	s6,64(sp)
    3624:	fc5e                	sd	s7,56(sp)
    3626:	f862                	sd	s8,48(sp)
    3628:	f466                	sd	s9,40(sp)
    362a:	f06a                	sd	s10,32(sp)
    362c:	ec6e                	sd	s11,24(sp)
    362e:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    3630:	0005c903          	lbu	s2,0(a1)
    3634:	18090f63          	beqz	s2,37d2 <vprintf+0x1c0>
    3638:	8aaa                	mv	s5,a0
    363a:	8b32                	mv	s6,a2
    363c:	00158493          	addi	s1,a1,1
  state = 0;
    3640:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3642:	02500a13          	li	s4,37
      if(c == 'd'){
    3646:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    364a:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    364e:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    3652:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3656:	00000b97          	auipc	s7,0x0
    365a:	3bab8b93          	addi	s7,s7,954 # 3a10 <digits>
    365e:	a839                	j	367c <vprintf+0x6a>
        putc(fd, c);
    3660:	85ca                	mv	a1,s2
    3662:	8556                	mv	a0,s5
    3664:	00000097          	auipc	ra,0x0
    3668:	ee2080e7          	jalr	-286(ra) # 3546 <putc>
    366c:	a019                	j	3672 <vprintf+0x60>
    } else if(state == '%'){
    366e:	01498f63          	beq	s3,s4,368c <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    3672:	0485                	addi	s1,s1,1
    3674:	fff4c903          	lbu	s2,-1(s1)
    3678:	14090d63          	beqz	s2,37d2 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    367c:	0009079b          	sext.w	a5,s2
    if(state == 0){
    3680:	fe0997e3          	bnez	s3,366e <vprintf+0x5c>
      if(c == '%'){
    3684:	fd479ee3          	bne	a5,s4,3660 <vprintf+0x4e>
        state = '%';
    3688:	89be                	mv	s3,a5
    368a:	b7e5                	j	3672 <vprintf+0x60>
      if(c == 'd'){
    368c:	05878063          	beq	a5,s8,36cc <vprintf+0xba>
      } else if(c == 'l') {
    3690:	05978c63          	beq	a5,s9,36e8 <vprintf+0xd6>
      } else if(c == 'x') {
    3694:	07a78863          	beq	a5,s10,3704 <vprintf+0xf2>
      } else if(c == 'p') {
    3698:	09b78463          	beq	a5,s11,3720 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    369c:	07300713          	li	a4,115
    36a0:	0ce78663          	beq	a5,a4,376c <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    36a4:	06300713          	li	a4,99
    36a8:	0ee78e63          	beq	a5,a4,37a4 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    36ac:	11478863          	beq	a5,s4,37bc <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    36b0:	85d2                	mv	a1,s4
    36b2:	8556                	mv	a0,s5
    36b4:	00000097          	auipc	ra,0x0
    36b8:	e92080e7          	jalr	-366(ra) # 3546 <putc>
        putc(fd, c);
    36bc:	85ca                	mv	a1,s2
    36be:	8556                	mv	a0,s5
    36c0:	00000097          	auipc	ra,0x0
    36c4:	e86080e7          	jalr	-378(ra) # 3546 <putc>
      }
      state = 0;
    36c8:	4981                	li	s3,0
    36ca:	b765                	j	3672 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    36cc:	008b0913          	addi	s2,s6,8
    36d0:	4685                	li	a3,1
    36d2:	4629                	li	a2,10
    36d4:	000b2583          	lw	a1,0(s6)
    36d8:	8556                	mv	a0,s5
    36da:	00000097          	auipc	ra,0x0
    36de:	e8e080e7          	jalr	-370(ra) # 3568 <printint>
    36e2:	8b4a                	mv	s6,s2
      state = 0;
    36e4:	4981                	li	s3,0
    36e6:	b771                	j	3672 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    36e8:	008b0913          	addi	s2,s6,8
    36ec:	4681                	li	a3,0
    36ee:	4629                	li	a2,10
    36f0:	000b2583          	lw	a1,0(s6)
    36f4:	8556                	mv	a0,s5
    36f6:	00000097          	auipc	ra,0x0
    36fa:	e72080e7          	jalr	-398(ra) # 3568 <printint>
    36fe:	8b4a                	mv	s6,s2
      state = 0;
    3700:	4981                	li	s3,0
    3702:	bf85                	j	3672 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    3704:	008b0913          	addi	s2,s6,8
    3708:	4681                	li	a3,0
    370a:	4641                	li	a2,16
    370c:	000b2583          	lw	a1,0(s6)
    3710:	8556                	mv	a0,s5
    3712:	00000097          	auipc	ra,0x0
    3716:	e56080e7          	jalr	-426(ra) # 3568 <printint>
    371a:	8b4a                	mv	s6,s2
      state = 0;
    371c:	4981                	li	s3,0
    371e:	bf91                	j	3672 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    3720:	008b0793          	addi	a5,s6,8
    3724:	f8f43423          	sd	a5,-120(s0)
    3728:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    372c:	03000593          	li	a1,48
    3730:	8556                	mv	a0,s5
    3732:	00000097          	auipc	ra,0x0
    3736:	e14080e7          	jalr	-492(ra) # 3546 <putc>
  putc(fd, 'x');
    373a:	85ea                	mv	a1,s10
    373c:	8556                	mv	a0,s5
    373e:	00000097          	auipc	ra,0x0
    3742:	e08080e7          	jalr	-504(ra) # 3546 <putc>
    3746:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3748:	03c9d793          	srli	a5,s3,0x3c
    374c:	97de                	add	a5,a5,s7
    374e:	0007c583          	lbu	a1,0(a5)
    3752:	8556                	mv	a0,s5
    3754:	00000097          	auipc	ra,0x0
    3758:	df2080e7          	jalr	-526(ra) # 3546 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    375c:	0992                	slli	s3,s3,0x4
    375e:	397d                	addiw	s2,s2,-1
    3760:	fe0914e3          	bnez	s2,3748 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    3764:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    3768:	4981                	li	s3,0
    376a:	b721                	j	3672 <vprintf+0x60>
        s = va_arg(ap, char*);
    376c:	008b0993          	addi	s3,s6,8
    3770:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    3774:	02090163          	beqz	s2,3796 <vprintf+0x184>
        while(*s != 0){
    3778:	00094583          	lbu	a1,0(s2)
    377c:	c9a1                	beqz	a1,37cc <vprintf+0x1ba>
          putc(fd, *s);
    377e:	8556                	mv	a0,s5
    3780:	00000097          	auipc	ra,0x0
    3784:	dc6080e7          	jalr	-570(ra) # 3546 <putc>
          s++;
    3788:	0905                	addi	s2,s2,1
        while(*s != 0){
    378a:	00094583          	lbu	a1,0(s2)
    378e:	f9e5                	bnez	a1,377e <vprintf+0x16c>
        s = va_arg(ap, char*);
    3790:	8b4e                	mv	s6,s3
      state = 0;
    3792:	4981                	li	s3,0
    3794:	bdf9                	j	3672 <vprintf+0x60>
          s = "(null)";
    3796:	00000917          	auipc	s2,0x0
    379a:	27290913          	addi	s2,s2,626 # 3a08 <malloc+0x12c>
        while(*s != 0){
    379e:	02800593          	li	a1,40
    37a2:	bff1                	j	377e <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    37a4:	008b0913          	addi	s2,s6,8
    37a8:	000b4583          	lbu	a1,0(s6)
    37ac:	8556                	mv	a0,s5
    37ae:	00000097          	auipc	ra,0x0
    37b2:	d98080e7          	jalr	-616(ra) # 3546 <putc>
    37b6:	8b4a                	mv	s6,s2
      state = 0;
    37b8:	4981                	li	s3,0
    37ba:	bd65                	j	3672 <vprintf+0x60>
        putc(fd, c);
    37bc:	85d2                	mv	a1,s4
    37be:	8556                	mv	a0,s5
    37c0:	00000097          	auipc	ra,0x0
    37c4:	d86080e7          	jalr	-634(ra) # 3546 <putc>
      state = 0;
    37c8:	4981                	li	s3,0
    37ca:	b565                	j	3672 <vprintf+0x60>
        s = va_arg(ap, char*);
    37cc:	8b4e                	mv	s6,s3
      state = 0;
    37ce:	4981                	li	s3,0
    37d0:	b54d                	j	3672 <vprintf+0x60>
    }
  }
}
    37d2:	70e6                	ld	ra,120(sp)
    37d4:	7446                	ld	s0,112(sp)
    37d6:	74a6                	ld	s1,104(sp)
    37d8:	7906                	ld	s2,96(sp)
    37da:	69e6                	ld	s3,88(sp)
    37dc:	6a46                	ld	s4,80(sp)
    37de:	6aa6                	ld	s5,72(sp)
    37e0:	6b06                	ld	s6,64(sp)
    37e2:	7be2                	ld	s7,56(sp)
    37e4:	7c42                	ld	s8,48(sp)
    37e6:	7ca2                	ld	s9,40(sp)
    37e8:	7d02                	ld	s10,32(sp)
    37ea:	6de2                	ld	s11,24(sp)
    37ec:	6109                	addi	sp,sp,128
    37ee:	8082                	ret

00000000000037f0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    37f0:	715d                	addi	sp,sp,-80
    37f2:	ec06                	sd	ra,24(sp)
    37f4:	e822                	sd	s0,16(sp)
    37f6:	1000                	addi	s0,sp,32
    37f8:	e010                	sd	a2,0(s0)
    37fa:	e414                	sd	a3,8(s0)
    37fc:	e818                	sd	a4,16(s0)
    37fe:	ec1c                	sd	a5,24(s0)
    3800:	03043023          	sd	a6,32(s0)
    3804:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    3808:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    380c:	8622                	mv	a2,s0
    380e:	00000097          	auipc	ra,0x0
    3812:	e04080e7          	jalr	-508(ra) # 3612 <vprintf>
}
    3816:	60e2                	ld	ra,24(sp)
    3818:	6442                	ld	s0,16(sp)
    381a:	6161                	addi	sp,sp,80
    381c:	8082                	ret

000000000000381e <printf>:

void
printf(const char *fmt, ...)
{
    381e:	711d                	addi	sp,sp,-96
    3820:	ec06                	sd	ra,24(sp)
    3822:	e822                	sd	s0,16(sp)
    3824:	1000                	addi	s0,sp,32
    3826:	e40c                	sd	a1,8(s0)
    3828:	e810                	sd	a2,16(s0)
    382a:	ec14                	sd	a3,24(s0)
    382c:	f018                	sd	a4,32(s0)
    382e:	f41c                	sd	a5,40(s0)
    3830:	03043823          	sd	a6,48(s0)
    3834:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    3838:	00840613          	addi	a2,s0,8
    383c:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    3840:	85aa                	mv	a1,a0
    3842:	4505                	li	a0,1
    3844:	00000097          	auipc	ra,0x0
    3848:	dce080e7          	jalr	-562(ra) # 3612 <vprintf>
}
    384c:	60e2                	ld	ra,24(sp)
    384e:	6442                	ld	s0,16(sp)
    3850:	6125                	addi	sp,sp,96
    3852:	8082                	ret

0000000000003854 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3854:	1141                	addi	sp,sp,-16
    3856:	e422                	sd	s0,8(sp)
    3858:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    385a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    385e:	00000797          	auipc	a5,0x0
    3862:	7a27b783          	ld	a5,1954(a5) # 4000 <freep>
    3866:	a805                	j	3896 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3868:	4618                	lw	a4,8(a2)
    386a:	9db9                	addw	a1,a1,a4
    386c:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    3870:	6398                	ld	a4,0(a5)
    3872:	6318                	ld	a4,0(a4)
    3874:	fee53823          	sd	a4,-16(a0)
    3878:	a091                	j	38bc <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    387a:	ff852703          	lw	a4,-8(a0)
    387e:	9e39                	addw	a2,a2,a4
    3880:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    3882:	ff053703          	ld	a4,-16(a0)
    3886:	e398                	sd	a4,0(a5)
    3888:	a099                	j	38ce <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    388a:	6398                	ld	a4,0(a5)
    388c:	00e7e463          	bltu	a5,a4,3894 <free+0x40>
    3890:	00e6ea63          	bltu	a3,a4,38a4 <free+0x50>
{
    3894:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3896:	fed7fae3          	bgeu	a5,a3,388a <free+0x36>
    389a:	6398                	ld	a4,0(a5)
    389c:	00e6e463          	bltu	a3,a4,38a4 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    38a0:	fee7eae3          	bltu	a5,a4,3894 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    38a4:	ff852583          	lw	a1,-8(a0)
    38a8:	6390                	ld	a2,0(a5)
    38aa:	02059713          	slli	a4,a1,0x20
    38ae:	9301                	srli	a4,a4,0x20
    38b0:	0712                	slli	a4,a4,0x4
    38b2:	9736                	add	a4,a4,a3
    38b4:	fae60ae3          	beq	a2,a4,3868 <free+0x14>
    bp->s.ptr = p->s.ptr;
    38b8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    38bc:	4790                	lw	a2,8(a5)
    38be:	02061713          	slli	a4,a2,0x20
    38c2:	9301                	srli	a4,a4,0x20
    38c4:	0712                	slli	a4,a4,0x4
    38c6:	973e                	add	a4,a4,a5
    38c8:	fae689e3          	beq	a3,a4,387a <free+0x26>
  } else
    p->s.ptr = bp;
    38cc:	e394                	sd	a3,0(a5)
  freep = p;
    38ce:	00000717          	auipc	a4,0x0
    38d2:	72f73923          	sd	a5,1842(a4) # 4000 <freep>
}
    38d6:	6422                	ld	s0,8(sp)
    38d8:	0141                	addi	sp,sp,16
    38da:	8082                	ret

00000000000038dc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    38dc:	7139                	addi	sp,sp,-64
    38de:	fc06                	sd	ra,56(sp)
    38e0:	f822                	sd	s0,48(sp)
    38e2:	f426                	sd	s1,40(sp)
    38e4:	f04a                	sd	s2,32(sp)
    38e6:	ec4e                	sd	s3,24(sp)
    38e8:	e852                	sd	s4,16(sp)
    38ea:	e456                	sd	s5,8(sp)
    38ec:	e05a                	sd	s6,0(sp)
    38ee:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    38f0:	02051493          	slli	s1,a0,0x20
    38f4:	9081                	srli	s1,s1,0x20
    38f6:	04bd                	addi	s1,s1,15
    38f8:	8091                	srli	s1,s1,0x4
    38fa:	0014899b          	addiw	s3,s1,1
    38fe:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    3900:	00000517          	auipc	a0,0x0
    3904:	70053503          	ld	a0,1792(a0) # 4000 <freep>
    3908:	c515                	beqz	a0,3934 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    390a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    390c:	4798                	lw	a4,8(a5)
    390e:	02977f63          	bgeu	a4,s1,394c <malloc+0x70>
    3912:	8a4e                	mv	s4,s3
    3914:	0009871b          	sext.w	a4,s3
    3918:	6685                	lui	a3,0x1
    391a:	00d77363          	bgeu	a4,a3,3920 <malloc+0x44>
    391e:	6a05                	lui	s4,0x1
    3920:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    3924:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3928:	00000917          	auipc	s2,0x0
    392c:	6d890913          	addi	s2,s2,1752 # 4000 <freep>
  if(p == (char*)-1)
    3930:	5afd                	li	s5,-1
    3932:	a88d                	j	39a4 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    3934:	00001797          	auipc	a5,0x1
    3938:	8dc78793          	addi	a5,a5,-1828 # 4210 <base>
    393c:	00000717          	auipc	a4,0x0
    3940:	6cf73223          	sd	a5,1732(a4) # 4000 <freep>
    3944:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    3946:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    394a:	b7e1                	j	3912 <malloc+0x36>
      if(p->s.size == nunits)
    394c:	02e48b63          	beq	s1,a4,3982 <malloc+0xa6>
        p->s.size -= nunits;
    3950:	4137073b          	subw	a4,a4,s3
    3954:	c798                	sw	a4,8(a5)
        p += p->s.size;
    3956:	1702                	slli	a4,a4,0x20
    3958:	9301                	srli	a4,a4,0x20
    395a:	0712                	slli	a4,a4,0x4
    395c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    395e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    3962:	00000717          	auipc	a4,0x0
    3966:	68a73f23          	sd	a0,1694(a4) # 4000 <freep>
      return (void*)(p + 1);
    396a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    396e:	70e2                	ld	ra,56(sp)
    3970:	7442                	ld	s0,48(sp)
    3972:	74a2                	ld	s1,40(sp)
    3974:	7902                	ld	s2,32(sp)
    3976:	69e2                	ld	s3,24(sp)
    3978:	6a42                	ld	s4,16(sp)
    397a:	6aa2                	ld	s5,8(sp)
    397c:	6b02                	ld	s6,0(sp)
    397e:	6121                	addi	sp,sp,64
    3980:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    3982:	6398                	ld	a4,0(a5)
    3984:	e118                	sd	a4,0(a0)
    3986:	bff1                	j	3962 <malloc+0x86>
  hp->s.size = nu;
    3988:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    398c:	0541                	addi	a0,a0,16
    398e:	00000097          	auipc	ra,0x0
    3992:	ec6080e7          	jalr	-314(ra) # 3854 <free>
  return freep;
    3996:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    399a:	d971                	beqz	a0,396e <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    399c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    399e:	4798                	lw	a4,8(a5)
    39a0:	fa9776e3          	bgeu	a4,s1,394c <malloc+0x70>
    if(p == freep)
    39a4:	00093703          	ld	a4,0(s2)
    39a8:	853e                	mv	a0,a5
    39aa:	fef719e3          	bne	a4,a5,399c <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    39ae:	8552                	mv	a0,s4
    39b0:	00000097          	auipc	ra,0x0
    39b4:	b56080e7          	jalr	-1194(ra) # 3506 <sbrk>
  if(p == (char*)-1)
    39b8:	fd5518e3          	bne	a0,s5,3988 <malloc+0xac>
        return 0;
    39bc:	4501                	li	a0,0
    39be:	bf45                	j	396e <malloc+0x92>
