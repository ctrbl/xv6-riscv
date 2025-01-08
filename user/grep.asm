
user/_grep:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
    3000:	7179                	addi	sp,sp,-48
    3002:	f406                	sd	ra,40(sp)
    3004:	f022                	sd	s0,32(sp)
    3006:	ec26                	sd	s1,24(sp)
    3008:	e84a                	sd	s2,16(sp)
    300a:	e44e                	sd	s3,8(sp)
    300c:	e052                	sd	s4,0(sp)
    300e:	1800                	addi	s0,sp,48
    3010:	892a                	mv	s2,a0
    3012:	89ae                	mv	s3,a1
    3014:	84b2                	mv	s1,a2
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
    3016:	02e00a13          	li	s4,46
    if(matchhere(re, text))
    301a:	85a6                	mv	a1,s1
    301c:	854e                	mv	a0,s3
    301e:	00000097          	auipc	ra,0x0
    3022:	030080e7          	jalr	48(ra) # 304e <matchhere>
    3026:	e919                	bnez	a0,303c <matchstar+0x3c>
  }while(*text!='\0' && (*text++==c || c=='.'));
    3028:	0004c783          	lbu	a5,0(s1)
    302c:	cb89                	beqz	a5,303e <matchstar+0x3e>
    302e:	0485                	addi	s1,s1,1
    3030:	2781                	sext.w	a5,a5
    3032:	ff2784e3          	beq	a5,s2,301a <matchstar+0x1a>
    3036:	ff4902e3          	beq	s2,s4,301a <matchstar+0x1a>
    303a:	a011                	j	303e <matchstar+0x3e>
      return 1;
    303c:	4505                	li	a0,1
  return 0;
}
    303e:	70a2                	ld	ra,40(sp)
    3040:	7402                	ld	s0,32(sp)
    3042:	64e2                	ld	s1,24(sp)
    3044:	6942                	ld	s2,16(sp)
    3046:	69a2                	ld	s3,8(sp)
    3048:	6a02                	ld	s4,0(sp)
    304a:	6145                	addi	sp,sp,48
    304c:	8082                	ret

000000000000304e <matchhere>:
  if(re[0] == '\0')
    304e:	00054703          	lbu	a4,0(a0)
    3052:	cb3d                	beqz	a4,30c8 <matchhere+0x7a>
{
    3054:	1141                	addi	sp,sp,-16
    3056:	e406                	sd	ra,8(sp)
    3058:	e022                	sd	s0,0(sp)
    305a:	0800                	addi	s0,sp,16
    305c:	87aa                	mv	a5,a0
  if(re[1] == '*')
    305e:	00154683          	lbu	a3,1(a0)
    3062:	02a00613          	li	a2,42
    3066:	02c68563          	beq	a3,a2,3090 <matchhere+0x42>
  if(re[0] == '$' && re[1] == '\0')
    306a:	02400613          	li	a2,36
    306e:	02c70a63          	beq	a4,a2,30a2 <matchhere+0x54>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    3072:	0005c683          	lbu	a3,0(a1)
  return 0;
    3076:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    3078:	ca81                	beqz	a3,3088 <matchhere+0x3a>
    307a:	02e00613          	li	a2,46
    307e:	02c70d63          	beq	a4,a2,30b8 <matchhere+0x6a>
  return 0;
    3082:	4501                	li	a0,0
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    3084:	02d70a63          	beq	a4,a3,30b8 <matchhere+0x6a>
}
    3088:	60a2                	ld	ra,8(sp)
    308a:	6402                	ld	s0,0(sp)
    308c:	0141                	addi	sp,sp,16
    308e:	8082                	ret
    return matchstar(re[0], re+2, text);
    3090:	862e                	mv	a2,a1
    3092:	00250593          	addi	a1,a0,2
    3096:	853a                	mv	a0,a4
    3098:	00000097          	auipc	ra,0x0
    309c:	f68080e7          	jalr	-152(ra) # 3000 <matchstar>
    30a0:	b7e5                	j	3088 <matchhere+0x3a>
  if(re[0] == '$' && re[1] == '\0')
    30a2:	c691                	beqz	a3,30ae <matchhere+0x60>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
    30a4:	0005c683          	lbu	a3,0(a1)
    30a8:	fee9                	bnez	a3,3082 <matchhere+0x34>
  return 0;
    30aa:	4501                	li	a0,0
    30ac:	bff1                	j	3088 <matchhere+0x3a>
    return *text == '\0';
    30ae:	0005c503          	lbu	a0,0(a1)
    30b2:	00153513          	seqz	a0,a0
    30b6:	bfc9                	j	3088 <matchhere+0x3a>
    return matchhere(re+1, text+1);
    30b8:	0585                	addi	a1,a1,1
    30ba:	00178513          	addi	a0,a5,1
    30be:	00000097          	auipc	ra,0x0
    30c2:	f90080e7          	jalr	-112(ra) # 304e <matchhere>
    30c6:	b7c9                	j	3088 <matchhere+0x3a>
    return 1;
    30c8:	4505                	li	a0,1
}
    30ca:	8082                	ret

00000000000030cc <match>:
{
    30cc:	1101                	addi	sp,sp,-32
    30ce:	ec06                	sd	ra,24(sp)
    30d0:	e822                	sd	s0,16(sp)
    30d2:	e426                	sd	s1,8(sp)
    30d4:	e04a                	sd	s2,0(sp)
    30d6:	1000                	addi	s0,sp,32
    30d8:	892a                	mv	s2,a0
    30da:	84ae                	mv	s1,a1
  if(re[0] == '^')
    30dc:	00054703          	lbu	a4,0(a0)
    30e0:	05e00793          	li	a5,94
    30e4:	00f70e63          	beq	a4,a5,3100 <match+0x34>
    if(matchhere(re, text))
    30e8:	85a6                	mv	a1,s1
    30ea:	854a                	mv	a0,s2
    30ec:	00000097          	auipc	ra,0x0
    30f0:	f62080e7          	jalr	-158(ra) # 304e <matchhere>
    30f4:	ed01                	bnez	a0,310c <match+0x40>
  }while(*text++ != '\0');
    30f6:	0485                	addi	s1,s1,1
    30f8:	fff4c783          	lbu	a5,-1(s1)
    30fc:	f7f5                	bnez	a5,30e8 <match+0x1c>
    30fe:	a801                	j	310e <match+0x42>
    return matchhere(re+1, text);
    3100:	0505                	addi	a0,a0,1
    3102:	00000097          	auipc	ra,0x0
    3106:	f4c080e7          	jalr	-180(ra) # 304e <matchhere>
    310a:	a011                	j	310e <match+0x42>
      return 1;
    310c:	4505                	li	a0,1
}
    310e:	60e2                	ld	ra,24(sp)
    3110:	6442                	ld	s0,16(sp)
    3112:	64a2                	ld	s1,8(sp)
    3114:	6902                	ld	s2,0(sp)
    3116:	6105                	addi	sp,sp,32
    3118:	8082                	ret

000000000000311a <grep>:
{
    311a:	715d                	addi	sp,sp,-80
    311c:	e486                	sd	ra,72(sp)
    311e:	e0a2                	sd	s0,64(sp)
    3120:	fc26                	sd	s1,56(sp)
    3122:	f84a                	sd	s2,48(sp)
    3124:	f44e                	sd	s3,40(sp)
    3126:	f052                	sd	s4,32(sp)
    3128:	ec56                	sd	s5,24(sp)
    312a:	e85a                	sd	s6,16(sp)
    312c:	e45e                	sd	s7,8(sp)
    312e:	0880                	addi	s0,sp,80
    3130:	89aa                	mv	s3,a0
    3132:	8b2e                	mv	s6,a1
  m = 0;
    3134:	4a01                	li	s4,0
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    3136:	3ff00b93          	li	s7,1023
    313a:	00001a97          	auipc	s5,0x1
    313e:	ed6a8a93          	addi	s5,s5,-298 # 4010 <buf>
    3142:	a0a1                	j	318a <grep+0x70>
      p = q+1;
    3144:	00148913          	addi	s2,s1,1
    while((q = strchr(p, '\n')) != 0){
    3148:	45a9                	li	a1,10
    314a:	854a                	mv	a0,s2
    314c:	00000097          	auipc	ra,0x0
    3150:	200080e7          	jalr	512(ra) # 334c <strchr>
    3154:	84aa                	mv	s1,a0
    3156:	c905                	beqz	a0,3186 <grep+0x6c>
      *q = 0;
    3158:	00048023          	sb	zero,0(s1)
      if(match(pattern, p)){
    315c:	85ca                	mv	a1,s2
    315e:	854e                	mv	a0,s3
    3160:	00000097          	auipc	ra,0x0
    3164:	f6c080e7          	jalr	-148(ra) # 30cc <match>
    3168:	dd71                	beqz	a0,3144 <grep+0x2a>
        *q = '\n';
    316a:	47a9                	li	a5,10
    316c:	00f48023          	sb	a5,0(s1)
        write(1, p, q+1 - p);
    3170:	00148613          	addi	a2,s1,1
    3174:	4126063b          	subw	a2,a2,s2
    3178:	85ca                	mv	a1,s2
    317a:	4505                	li	a0,1
    317c:	00000097          	auipc	ra,0x0
    3180:	42a080e7          	jalr	1066(ra) # 35a6 <write>
    3184:	b7c1                	j	3144 <grep+0x2a>
    if(m > 0){
    3186:	03404563          	bgtz	s4,31b0 <grep+0x96>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
    318a:	414b863b          	subw	a2,s7,s4
    318e:	014a85b3          	add	a1,s5,s4
    3192:	855a                	mv	a0,s6
    3194:	00000097          	auipc	ra,0x0
    3198:	40a080e7          	jalr	1034(ra) # 359e <read>
    319c:	02a05663          	blez	a0,31c8 <grep+0xae>
    m += n;
    31a0:	00aa0a3b          	addw	s4,s4,a0
    buf[m] = '\0';
    31a4:	014a87b3          	add	a5,s5,s4
    31a8:	00078023          	sb	zero,0(a5)
    p = buf;
    31ac:	8956                	mv	s2,s5
    while((q = strchr(p, '\n')) != 0){
    31ae:	bf69                	j	3148 <grep+0x2e>
      m -= p - buf;
    31b0:	415907b3          	sub	a5,s2,s5
    31b4:	40fa0a3b          	subw	s4,s4,a5
      memmove(buf, p, m);
    31b8:	8652                	mv	a2,s4
    31ba:	85ca                	mv	a1,s2
    31bc:	8556                	mv	a0,s5
    31be:	00000097          	auipc	ra,0x0
    31c2:	2b6080e7          	jalr	694(ra) # 3474 <memmove>
    31c6:	b7d1                	j	318a <grep+0x70>
}
    31c8:	60a6                	ld	ra,72(sp)
    31ca:	6406                	ld	s0,64(sp)
    31cc:	74e2                	ld	s1,56(sp)
    31ce:	7942                	ld	s2,48(sp)
    31d0:	79a2                	ld	s3,40(sp)
    31d2:	7a02                	ld	s4,32(sp)
    31d4:	6ae2                	ld	s5,24(sp)
    31d6:	6b42                	ld	s6,16(sp)
    31d8:	6ba2                	ld	s7,8(sp)
    31da:	6161                	addi	sp,sp,80
    31dc:	8082                	ret

00000000000031de <main>:
{
    31de:	7139                	addi	sp,sp,-64
    31e0:	fc06                	sd	ra,56(sp)
    31e2:	f822                	sd	s0,48(sp)
    31e4:	f426                	sd	s1,40(sp)
    31e6:	f04a                	sd	s2,32(sp)
    31e8:	ec4e                	sd	s3,24(sp)
    31ea:	e852                	sd	s4,16(sp)
    31ec:	e456                	sd	s5,8(sp)
    31ee:	0080                	addi	s0,sp,64
  if(argc <= 1){
    31f0:	4785                	li	a5,1
    31f2:	04a7de63          	bge	a5,a0,324e <main+0x70>
  pattern = argv[1];
    31f6:	0085ba03          	ld	s4,8(a1)
  if(argc <= 2){
    31fa:	4789                	li	a5,2
    31fc:	06a7d763          	bge	a5,a0,326a <main+0x8c>
    3200:	01058913          	addi	s2,a1,16
    3204:	ffd5099b          	addiw	s3,a0,-3
    3208:	1982                	slli	s3,s3,0x20
    320a:	0209d993          	srli	s3,s3,0x20
    320e:	098e                	slli	s3,s3,0x3
    3210:	05e1                	addi	a1,a1,24
    3212:	99ae                	add	s3,s3,a1
    if((fd = open(argv[i], 0)) < 0){
    3214:	4581                	li	a1,0
    3216:	00093503          	ld	a0,0(s2)
    321a:	00000097          	auipc	ra,0x0
    321e:	3ac080e7          	jalr	940(ra) # 35c6 <open>
    3222:	84aa                	mv	s1,a0
    3224:	04054e63          	bltz	a0,3280 <main+0xa2>
    grep(pattern, fd);
    3228:	85aa                	mv	a1,a0
    322a:	8552                	mv	a0,s4
    322c:	00000097          	auipc	ra,0x0
    3230:	eee080e7          	jalr	-274(ra) # 311a <grep>
    close(fd);
    3234:	8526                	mv	a0,s1
    3236:	00000097          	auipc	ra,0x0
    323a:	378080e7          	jalr	888(ra) # 35ae <close>
  for(i = 2; i < argc; i++){
    323e:	0921                	addi	s2,s2,8
    3240:	fd391ae3          	bne	s2,s3,3214 <main+0x36>
  exit(0);
    3244:	4501                	li	a0,0
    3246:	00000097          	auipc	ra,0x0
    324a:	338080e7          	jalr	824(ra) # 357e <exit>
    fprintf(2, "usage: grep pattern [file ...]\n");
    324e:	00001597          	auipc	a1,0x1
    3252:	88258593          	addi	a1,a1,-1918 # 3ad0 <malloc+0xec>
    3256:	4509                	li	a0,2
    3258:	00000097          	auipc	ra,0x0
    325c:	6a0080e7          	jalr	1696(ra) # 38f8 <fprintf>
    exit(1);
    3260:	4505                	li	a0,1
    3262:	00000097          	auipc	ra,0x0
    3266:	31c080e7          	jalr	796(ra) # 357e <exit>
    grep(pattern, 0);
    326a:	4581                	li	a1,0
    326c:	8552                	mv	a0,s4
    326e:	00000097          	auipc	ra,0x0
    3272:	eac080e7          	jalr	-340(ra) # 311a <grep>
    exit(0);
    3276:	4501                	li	a0,0
    3278:	00000097          	auipc	ra,0x0
    327c:	306080e7          	jalr	774(ra) # 357e <exit>
      printf("grep: cannot open %s\n", argv[i]);
    3280:	00093583          	ld	a1,0(s2)
    3284:	00001517          	auipc	a0,0x1
    3288:	86c50513          	addi	a0,a0,-1940 # 3af0 <malloc+0x10c>
    328c:	00000097          	auipc	ra,0x0
    3290:	69a080e7          	jalr	1690(ra) # 3926 <printf>
      exit(1);
    3294:	4505                	li	a0,1
    3296:	00000097          	auipc	ra,0x0
    329a:	2e8080e7          	jalr	744(ra) # 357e <exit>

000000000000329e <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    329e:	1141                	addi	sp,sp,-16
    32a0:	e406                	sd	ra,8(sp)
    32a2:	e022                	sd	s0,0(sp)
    32a4:	0800                	addi	s0,sp,16
  extern int main();
  main();
    32a6:	00000097          	auipc	ra,0x0
    32aa:	f38080e7          	jalr	-200(ra) # 31de <main>
  exit(0);
    32ae:	4501                	li	a0,0
    32b0:	00000097          	auipc	ra,0x0
    32b4:	2ce080e7          	jalr	718(ra) # 357e <exit>

00000000000032b8 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    32b8:	1141                	addi	sp,sp,-16
    32ba:	e422                	sd	s0,8(sp)
    32bc:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    32be:	87aa                	mv	a5,a0
    32c0:	0585                	addi	a1,a1,1
    32c2:	0785                	addi	a5,a5,1
    32c4:	fff5c703          	lbu	a4,-1(a1)
    32c8:	fee78fa3          	sb	a4,-1(a5)
    32cc:	fb75                	bnez	a4,32c0 <strcpy+0x8>
    ;
  return os;
}
    32ce:	6422                	ld	s0,8(sp)
    32d0:	0141                	addi	sp,sp,16
    32d2:	8082                	ret

00000000000032d4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    32d4:	1141                	addi	sp,sp,-16
    32d6:	e422                	sd	s0,8(sp)
    32d8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    32da:	00054783          	lbu	a5,0(a0)
    32de:	cb91                	beqz	a5,32f2 <strcmp+0x1e>
    32e0:	0005c703          	lbu	a4,0(a1)
    32e4:	00f71763          	bne	a4,a5,32f2 <strcmp+0x1e>
    p++, q++;
    32e8:	0505                	addi	a0,a0,1
    32ea:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    32ec:	00054783          	lbu	a5,0(a0)
    32f0:	fbe5                	bnez	a5,32e0 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    32f2:	0005c503          	lbu	a0,0(a1)
}
    32f6:	40a7853b          	subw	a0,a5,a0
    32fa:	6422                	ld	s0,8(sp)
    32fc:	0141                	addi	sp,sp,16
    32fe:	8082                	ret

0000000000003300 <strlen>:

uint
strlen(const char *s)
{
    3300:	1141                	addi	sp,sp,-16
    3302:	e422                	sd	s0,8(sp)
    3304:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    3306:	00054783          	lbu	a5,0(a0)
    330a:	cf91                	beqz	a5,3326 <strlen+0x26>
    330c:	0505                	addi	a0,a0,1
    330e:	87aa                	mv	a5,a0
    3310:	4685                	li	a3,1
    3312:	9e89                	subw	a3,a3,a0
    3314:	00f6853b          	addw	a0,a3,a5
    3318:	0785                	addi	a5,a5,1
    331a:	fff7c703          	lbu	a4,-1(a5)
    331e:	fb7d                	bnez	a4,3314 <strlen+0x14>
    ;
  return n;
}
    3320:	6422                	ld	s0,8(sp)
    3322:	0141                	addi	sp,sp,16
    3324:	8082                	ret
  for(n = 0; s[n]; n++)
    3326:	4501                	li	a0,0
    3328:	bfe5                	j	3320 <strlen+0x20>

000000000000332a <memset>:

void*
memset(void *dst, int c, uint n)
{
    332a:	1141                	addi	sp,sp,-16
    332c:	e422                	sd	s0,8(sp)
    332e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    3330:	ca19                	beqz	a2,3346 <memset+0x1c>
    3332:	87aa                	mv	a5,a0
    3334:	1602                	slli	a2,a2,0x20
    3336:	9201                	srli	a2,a2,0x20
    3338:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    333c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    3340:	0785                	addi	a5,a5,1
    3342:	fee79de3          	bne	a5,a4,333c <memset+0x12>
  }
  return dst;
}
    3346:	6422                	ld	s0,8(sp)
    3348:	0141                	addi	sp,sp,16
    334a:	8082                	ret

000000000000334c <strchr>:

char*
strchr(const char *s, char c)
{
    334c:	1141                	addi	sp,sp,-16
    334e:	e422                	sd	s0,8(sp)
    3350:	0800                	addi	s0,sp,16
  for(; *s; s++)
    3352:	00054783          	lbu	a5,0(a0)
    3356:	cb99                	beqz	a5,336c <strchr+0x20>
    if(*s == c)
    3358:	00f58763          	beq	a1,a5,3366 <strchr+0x1a>
  for(; *s; s++)
    335c:	0505                	addi	a0,a0,1
    335e:	00054783          	lbu	a5,0(a0)
    3362:	fbfd                	bnez	a5,3358 <strchr+0xc>
      return (char*)s;
  return 0;
    3364:	4501                	li	a0,0
}
    3366:	6422                	ld	s0,8(sp)
    3368:	0141                	addi	sp,sp,16
    336a:	8082                	ret
  return 0;
    336c:	4501                	li	a0,0
    336e:	bfe5                	j	3366 <strchr+0x1a>

0000000000003370 <gets>:

char*
gets(char *buf, int max)
{
    3370:	711d                	addi	sp,sp,-96
    3372:	ec86                	sd	ra,88(sp)
    3374:	e8a2                	sd	s0,80(sp)
    3376:	e4a6                	sd	s1,72(sp)
    3378:	e0ca                	sd	s2,64(sp)
    337a:	fc4e                	sd	s3,56(sp)
    337c:	f852                	sd	s4,48(sp)
    337e:	f456                	sd	s5,40(sp)
    3380:	f05a                	sd	s6,32(sp)
    3382:	ec5e                	sd	s7,24(sp)
    3384:	1080                	addi	s0,sp,96
    3386:	8baa                	mv	s7,a0
    3388:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    338a:	892a                	mv	s2,a0
    338c:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    338e:	4aa9                	li	s5,10
    3390:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    3392:	89a6                	mv	s3,s1
    3394:	2485                	addiw	s1,s1,1
    3396:	0344d863          	bge	s1,s4,33c6 <gets+0x56>
    cc = read(0, &c, 1);
    339a:	4605                	li	a2,1
    339c:	faf40593          	addi	a1,s0,-81
    33a0:	4501                	li	a0,0
    33a2:	00000097          	auipc	ra,0x0
    33a6:	1fc080e7          	jalr	508(ra) # 359e <read>
    if(cc < 1)
    33aa:	00a05e63          	blez	a0,33c6 <gets+0x56>
    buf[i++] = c;
    33ae:	faf44783          	lbu	a5,-81(s0)
    33b2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    33b6:	01578763          	beq	a5,s5,33c4 <gets+0x54>
    33ba:	0905                	addi	s2,s2,1
    33bc:	fd679be3          	bne	a5,s6,3392 <gets+0x22>
  for(i=0; i+1 < max; ){
    33c0:	89a6                	mv	s3,s1
    33c2:	a011                	j	33c6 <gets+0x56>
    33c4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    33c6:	99de                	add	s3,s3,s7
    33c8:	00098023          	sb	zero,0(s3)
  return buf;
}
    33cc:	855e                	mv	a0,s7
    33ce:	60e6                	ld	ra,88(sp)
    33d0:	6446                	ld	s0,80(sp)
    33d2:	64a6                	ld	s1,72(sp)
    33d4:	6906                	ld	s2,64(sp)
    33d6:	79e2                	ld	s3,56(sp)
    33d8:	7a42                	ld	s4,48(sp)
    33da:	7aa2                	ld	s5,40(sp)
    33dc:	7b02                	ld	s6,32(sp)
    33de:	6be2                	ld	s7,24(sp)
    33e0:	6125                	addi	sp,sp,96
    33e2:	8082                	ret

00000000000033e4 <stat>:

int
stat(const char *n, struct stat *st)
{
    33e4:	1101                	addi	sp,sp,-32
    33e6:	ec06                	sd	ra,24(sp)
    33e8:	e822                	sd	s0,16(sp)
    33ea:	e426                	sd	s1,8(sp)
    33ec:	e04a                	sd	s2,0(sp)
    33ee:	1000                	addi	s0,sp,32
    33f0:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    33f2:	4581                	li	a1,0
    33f4:	00000097          	auipc	ra,0x0
    33f8:	1d2080e7          	jalr	466(ra) # 35c6 <open>
  if(fd < 0)
    33fc:	02054563          	bltz	a0,3426 <stat+0x42>
    3400:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    3402:	85ca                	mv	a1,s2
    3404:	00000097          	auipc	ra,0x0
    3408:	1da080e7          	jalr	474(ra) # 35de <fstat>
    340c:	892a                	mv	s2,a0
  close(fd);
    340e:	8526                	mv	a0,s1
    3410:	00000097          	auipc	ra,0x0
    3414:	19e080e7          	jalr	414(ra) # 35ae <close>
  return r;
}
    3418:	854a                	mv	a0,s2
    341a:	60e2                	ld	ra,24(sp)
    341c:	6442                	ld	s0,16(sp)
    341e:	64a2                	ld	s1,8(sp)
    3420:	6902                	ld	s2,0(sp)
    3422:	6105                	addi	sp,sp,32
    3424:	8082                	ret
    return -1;
    3426:	597d                	li	s2,-1
    3428:	bfc5                	j	3418 <stat+0x34>

000000000000342a <atoi>:

int
atoi(const char *s)
{
    342a:	1141                	addi	sp,sp,-16
    342c:	e422                	sd	s0,8(sp)
    342e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3430:	00054603          	lbu	a2,0(a0)
    3434:	fd06079b          	addiw	a5,a2,-48
    3438:	0ff7f793          	andi	a5,a5,255
    343c:	4725                	li	a4,9
    343e:	02f76963          	bltu	a4,a5,3470 <atoi+0x46>
    3442:	86aa                	mv	a3,a0
  n = 0;
    3444:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    3446:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    3448:	0685                	addi	a3,a3,1
    344a:	0025179b          	slliw	a5,a0,0x2
    344e:	9fa9                	addw	a5,a5,a0
    3450:	0017979b          	slliw	a5,a5,0x1
    3454:	9fb1                	addw	a5,a5,a2
    3456:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    345a:	0006c603          	lbu	a2,0(a3)
    345e:	fd06071b          	addiw	a4,a2,-48
    3462:	0ff77713          	andi	a4,a4,255
    3466:	fee5f1e3          	bgeu	a1,a4,3448 <atoi+0x1e>
  return n;
}
    346a:	6422                	ld	s0,8(sp)
    346c:	0141                	addi	sp,sp,16
    346e:	8082                	ret
  n = 0;
    3470:	4501                	li	a0,0
    3472:	bfe5                	j	346a <atoi+0x40>

0000000000003474 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3474:	1141                	addi	sp,sp,-16
    3476:	e422                	sd	s0,8(sp)
    3478:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    347a:	02b57463          	bgeu	a0,a1,34a2 <memmove+0x2e>
    while(n-- > 0)
    347e:	00c05f63          	blez	a2,349c <memmove+0x28>
    3482:	1602                	slli	a2,a2,0x20
    3484:	9201                	srli	a2,a2,0x20
    3486:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    348a:	872a                	mv	a4,a0
      *dst++ = *src++;
    348c:	0585                	addi	a1,a1,1
    348e:	0705                	addi	a4,a4,1
    3490:	fff5c683          	lbu	a3,-1(a1)
    3494:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    3498:	fee79ae3          	bne	a5,a4,348c <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    349c:	6422                	ld	s0,8(sp)
    349e:	0141                	addi	sp,sp,16
    34a0:	8082                	ret
    dst += n;
    34a2:	00c50733          	add	a4,a0,a2
    src += n;
    34a6:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    34a8:	fec05ae3          	blez	a2,349c <memmove+0x28>
    34ac:	fff6079b          	addiw	a5,a2,-1
    34b0:	1782                	slli	a5,a5,0x20
    34b2:	9381                	srli	a5,a5,0x20
    34b4:	fff7c793          	not	a5,a5
    34b8:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    34ba:	15fd                	addi	a1,a1,-1
    34bc:	177d                	addi	a4,a4,-1
    34be:	0005c683          	lbu	a3,0(a1)
    34c2:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    34c6:	fee79ae3          	bne	a5,a4,34ba <memmove+0x46>
    34ca:	bfc9                	j	349c <memmove+0x28>

00000000000034cc <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    34cc:	1141                	addi	sp,sp,-16
    34ce:	e422                	sd	s0,8(sp)
    34d0:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    34d2:	ca05                	beqz	a2,3502 <memcmp+0x36>
    34d4:	fff6069b          	addiw	a3,a2,-1
    34d8:	1682                	slli	a3,a3,0x20
    34da:	9281                	srli	a3,a3,0x20
    34dc:	0685                	addi	a3,a3,1
    34de:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    34e0:	00054783          	lbu	a5,0(a0)
    34e4:	0005c703          	lbu	a4,0(a1)
    34e8:	00e79863          	bne	a5,a4,34f8 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    34ec:	0505                	addi	a0,a0,1
    p2++;
    34ee:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    34f0:	fed518e3          	bne	a0,a3,34e0 <memcmp+0x14>
  }
  return 0;
    34f4:	4501                	li	a0,0
    34f6:	a019                	j	34fc <memcmp+0x30>
      return *p1 - *p2;
    34f8:	40e7853b          	subw	a0,a5,a4
}
    34fc:	6422                	ld	s0,8(sp)
    34fe:	0141                	addi	sp,sp,16
    3500:	8082                	ret
  return 0;
    3502:	4501                	li	a0,0
    3504:	bfe5                	j	34fc <memcmp+0x30>

0000000000003506 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    3506:	1141                	addi	sp,sp,-16
    3508:	e406                	sd	ra,8(sp)
    350a:	e022                	sd	s0,0(sp)
    350c:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    350e:	00000097          	auipc	ra,0x0
    3512:	f66080e7          	jalr	-154(ra) # 3474 <memmove>
}
    3516:	60a2                	ld	ra,8(sp)
    3518:	6402                	ld	s0,0(sp)
    351a:	0141                	addi	sp,sp,16
    351c:	8082                	ret

000000000000351e <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    351e:	1141                	addi	sp,sp,-16
    3520:	e422                	sd	s0,8(sp)
    3522:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    3524:	00052023          	sw	zero,0(a0)
}  
    3528:	6422                	ld	s0,8(sp)
    352a:	0141                	addi	sp,sp,16
    352c:	8082                	ret

000000000000352e <lock>:

void lock(struct spinlock * lk) 
{    
    352e:	1141                	addi	sp,sp,-16
    3530:	e422                	sd	s0,8(sp)
    3532:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    3534:	4705                	li	a4,1
    3536:	87ba                	mv	a5,a4
    3538:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    353c:	2781                	sext.w	a5,a5
    353e:	ffe5                	bnez	a5,3536 <lock+0x8>
}  
    3540:	6422                	ld	s0,8(sp)
    3542:	0141                	addi	sp,sp,16
    3544:	8082                	ret

0000000000003546 <unlock>:

void unlock(struct spinlock * lk) 
{   
    3546:	1141                	addi	sp,sp,-16
    3548:	e422                	sd	s0,8(sp)
    354a:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    354c:	0f50000f          	fence	iorw,ow
    3550:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    3554:	6422                	ld	s0,8(sp)
    3556:	0141                	addi	sp,sp,16
    3558:	8082                	ret

000000000000355a <isDigit>:

unsigned int isDigit(char *c) {
    355a:	1141                	addi	sp,sp,-16
    355c:	e422                	sd	s0,8(sp)
    355e:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    3560:	00054503          	lbu	a0,0(a0)
    3564:	fd05051b          	addiw	a0,a0,-48
    3568:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    356c:	00a53513          	sltiu	a0,a0,10
    3570:	6422                	ld	s0,8(sp)
    3572:	0141                	addi	sp,sp,16
    3574:	8082                	ret

0000000000003576 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    3576:	4885                	li	a7,1
 ecall
    3578:	00000073          	ecall
 ret
    357c:	8082                	ret

000000000000357e <exit>:
.global exit
exit:
 li a7, SYS_exit
    357e:	4889                	li	a7,2
 ecall
    3580:	00000073          	ecall
 ret
    3584:	8082                	ret

0000000000003586 <wait>:
.global wait
wait:
 li a7, SYS_wait
    3586:	488d                	li	a7,3
 ecall
    3588:	00000073          	ecall
 ret
    358c:	8082                	ret

000000000000358e <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    358e:	48e1                	li	a7,24
 ecall
    3590:	00000073          	ecall
 ret
    3594:	8082                	ret

0000000000003596 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    3596:	4891                	li	a7,4
 ecall
    3598:	00000073          	ecall
 ret
    359c:	8082                	ret

000000000000359e <read>:
.global read
read:
 li a7, SYS_read
    359e:	4895                	li	a7,5
 ecall
    35a0:	00000073          	ecall
 ret
    35a4:	8082                	ret

00000000000035a6 <write>:
.global write
write:
 li a7, SYS_write
    35a6:	48c1                	li	a7,16
 ecall
    35a8:	00000073          	ecall
 ret
    35ac:	8082                	ret

00000000000035ae <close>:
.global close
close:
 li a7, SYS_close
    35ae:	48d5                	li	a7,21
 ecall
    35b0:	00000073          	ecall
 ret
    35b4:	8082                	ret

00000000000035b6 <kill>:
.global kill
kill:
 li a7, SYS_kill
    35b6:	4899                	li	a7,6
 ecall
    35b8:	00000073          	ecall
 ret
    35bc:	8082                	ret

00000000000035be <exec>:
.global exec
exec:
 li a7, SYS_exec
    35be:	489d                	li	a7,7
 ecall
    35c0:	00000073          	ecall
 ret
    35c4:	8082                	ret

00000000000035c6 <open>:
.global open
open:
 li a7, SYS_open
    35c6:	48bd                	li	a7,15
 ecall
    35c8:	00000073          	ecall
 ret
    35cc:	8082                	ret

00000000000035ce <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    35ce:	48c5                	li	a7,17
 ecall
    35d0:	00000073          	ecall
 ret
    35d4:	8082                	ret

00000000000035d6 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    35d6:	48c9                	li	a7,18
 ecall
    35d8:	00000073          	ecall
 ret
    35dc:	8082                	ret

00000000000035de <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    35de:	48a1                	li	a7,8
 ecall
    35e0:	00000073          	ecall
 ret
    35e4:	8082                	ret

00000000000035e6 <link>:
.global link
link:
 li a7, SYS_link
    35e6:	48cd                	li	a7,19
 ecall
    35e8:	00000073          	ecall
 ret
    35ec:	8082                	ret

00000000000035ee <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    35ee:	48d1                	li	a7,20
 ecall
    35f0:	00000073          	ecall
 ret
    35f4:	8082                	ret

00000000000035f6 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    35f6:	48a5                	li	a7,9
 ecall
    35f8:	00000073          	ecall
 ret
    35fc:	8082                	ret

00000000000035fe <dup>:
.global dup
dup:
 li a7, SYS_dup
    35fe:	48a9                	li	a7,10
 ecall
    3600:	00000073          	ecall
 ret
    3604:	8082                	ret

0000000000003606 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    3606:	48ad                	li	a7,11
 ecall
    3608:	00000073          	ecall
 ret
    360c:	8082                	ret

000000000000360e <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    360e:	48b1                	li	a7,12
 ecall
    3610:	00000073          	ecall
 ret
    3614:	8082                	ret

0000000000003616 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    3616:	48b5                	li	a7,13
 ecall
    3618:	00000073          	ecall
 ret
    361c:	8082                	ret

000000000000361e <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    361e:	48b9                	li	a7,14
 ecall
    3620:	00000073          	ecall
 ret
    3624:	8082                	ret

0000000000003626 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    3626:	48d9                	li	a7,22
 ecall
    3628:	00000073          	ecall
 ret
    362c:	8082                	ret

000000000000362e <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    362e:	48dd                	li	a7,23
 ecall
    3630:	00000073          	ecall
 ret
    3634:	8082                	ret

0000000000003636 <ps>:
.global ps
ps:
 li a7, SYS_ps
    3636:	48e5                	li	a7,25
 ecall
    3638:	00000073          	ecall
 ret
    363c:	8082                	ret

000000000000363e <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    363e:	48e9                	li	a7,26
 ecall
    3640:	00000073          	ecall
 ret
    3644:	8082                	ret

0000000000003646 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    3646:	48ed                	li	a7,27
 ecall
    3648:	00000073          	ecall
 ret
    364c:	8082                	ret

000000000000364e <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    364e:	1101                	addi	sp,sp,-32
    3650:	ec06                	sd	ra,24(sp)
    3652:	e822                	sd	s0,16(sp)
    3654:	1000                	addi	s0,sp,32
    3656:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    365a:	4605                	li	a2,1
    365c:	fef40593          	addi	a1,s0,-17
    3660:	00000097          	auipc	ra,0x0
    3664:	f46080e7          	jalr	-186(ra) # 35a6 <write>
}
    3668:	60e2                	ld	ra,24(sp)
    366a:	6442                	ld	s0,16(sp)
    366c:	6105                	addi	sp,sp,32
    366e:	8082                	ret

0000000000003670 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3670:	7139                	addi	sp,sp,-64
    3672:	fc06                	sd	ra,56(sp)
    3674:	f822                	sd	s0,48(sp)
    3676:	f426                	sd	s1,40(sp)
    3678:	f04a                	sd	s2,32(sp)
    367a:	ec4e                	sd	s3,24(sp)
    367c:	0080                	addi	s0,sp,64
    367e:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3680:	c299                	beqz	a3,3686 <printint+0x16>
    3682:	0805c863          	bltz	a1,3712 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3686:	2581                	sext.w	a1,a1
  neg = 0;
    3688:	4881                	li	a7,0
    368a:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    368e:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    3690:	2601                	sext.w	a2,a2
    3692:	00000517          	auipc	a0,0x0
    3696:	47e50513          	addi	a0,a0,1150 # 3b10 <digits>
    369a:	883a                	mv	a6,a4
    369c:	2705                	addiw	a4,a4,1
    369e:	02c5f7bb          	remuw	a5,a1,a2
    36a2:	1782                	slli	a5,a5,0x20
    36a4:	9381                	srli	a5,a5,0x20
    36a6:	97aa                	add	a5,a5,a0
    36a8:	0007c783          	lbu	a5,0(a5)
    36ac:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    36b0:	0005879b          	sext.w	a5,a1
    36b4:	02c5d5bb          	divuw	a1,a1,a2
    36b8:	0685                	addi	a3,a3,1
    36ba:	fec7f0e3          	bgeu	a5,a2,369a <printint+0x2a>
  if(neg)
    36be:	00088b63          	beqz	a7,36d4 <printint+0x64>
    buf[i++] = '-';
    36c2:	fd040793          	addi	a5,s0,-48
    36c6:	973e                	add	a4,a4,a5
    36c8:	02d00793          	li	a5,45
    36cc:	fef70823          	sb	a5,-16(a4)
    36d0:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    36d4:	02e05863          	blez	a4,3704 <printint+0x94>
    36d8:	fc040793          	addi	a5,s0,-64
    36dc:	00e78933          	add	s2,a5,a4
    36e0:	fff78993          	addi	s3,a5,-1
    36e4:	99ba                	add	s3,s3,a4
    36e6:	377d                	addiw	a4,a4,-1
    36e8:	1702                	slli	a4,a4,0x20
    36ea:	9301                	srli	a4,a4,0x20
    36ec:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    36f0:	fff94583          	lbu	a1,-1(s2)
    36f4:	8526                	mv	a0,s1
    36f6:	00000097          	auipc	ra,0x0
    36fa:	f58080e7          	jalr	-168(ra) # 364e <putc>
  while(--i >= 0)
    36fe:	197d                	addi	s2,s2,-1
    3700:	ff3918e3          	bne	s2,s3,36f0 <printint+0x80>
}
    3704:	70e2                	ld	ra,56(sp)
    3706:	7442                	ld	s0,48(sp)
    3708:	74a2                	ld	s1,40(sp)
    370a:	7902                	ld	s2,32(sp)
    370c:	69e2                	ld	s3,24(sp)
    370e:	6121                	addi	sp,sp,64
    3710:	8082                	ret
    x = -xx;
    3712:	40b005bb          	negw	a1,a1
    neg = 1;
    3716:	4885                	li	a7,1
    x = -xx;
    3718:	bf8d                	j	368a <printint+0x1a>

000000000000371a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    371a:	7119                	addi	sp,sp,-128
    371c:	fc86                	sd	ra,120(sp)
    371e:	f8a2                	sd	s0,112(sp)
    3720:	f4a6                	sd	s1,104(sp)
    3722:	f0ca                	sd	s2,96(sp)
    3724:	ecce                	sd	s3,88(sp)
    3726:	e8d2                	sd	s4,80(sp)
    3728:	e4d6                	sd	s5,72(sp)
    372a:	e0da                	sd	s6,64(sp)
    372c:	fc5e                	sd	s7,56(sp)
    372e:	f862                	sd	s8,48(sp)
    3730:	f466                	sd	s9,40(sp)
    3732:	f06a                	sd	s10,32(sp)
    3734:	ec6e                	sd	s11,24(sp)
    3736:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    3738:	0005c903          	lbu	s2,0(a1)
    373c:	18090f63          	beqz	s2,38da <vprintf+0x1c0>
    3740:	8aaa                	mv	s5,a0
    3742:	8b32                	mv	s6,a2
    3744:	00158493          	addi	s1,a1,1
  state = 0;
    3748:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    374a:	02500a13          	li	s4,37
      if(c == 'd'){
    374e:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    3752:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    3756:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    375a:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    375e:	00000b97          	auipc	s7,0x0
    3762:	3b2b8b93          	addi	s7,s7,946 # 3b10 <digits>
    3766:	a839                	j	3784 <vprintf+0x6a>
        putc(fd, c);
    3768:	85ca                	mv	a1,s2
    376a:	8556                	mv	a0,s5
    376c:	00000097          	auipc	ra,0x0
    3770:	ee2080e7          	jalr	-286(ra) # 364e <putc>
    3774:	a019                	j	377a <vprintf+0x60>
    } else if(state == '%'){
    3776:	01498f63          	beq	s3,s4,3794 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    377a:	0485                	addi	s1,s1,1
    377c:	fff4c903          	lbu	s2,-1(s1)
    3780:	14090d63          	beqz	s2,38da <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    3784:	0009079b          	sext.w	a5,s2
    if(state == 0){
    3788:	fe0997e3          	bnez	s3,3776 <vprintf+0x5c>
      if(c == '%'){
    378c:	fd479ee3          	bne	a5,s4,3768 <vprintf+0x4e>
        state = '%';
    3790:	89be                	mv	s3,a5
    3792:	b7e5                	j	377a <vprintf+0x60>
      if(c == 'd'){
    3794:	05878063          	beq	a5,s8,37d4 <vprintf+0xba>
      } else if(c == 'l') {
    3798:	05978c63          	beq	a5,s9,37f0 <vprintf+0xd6>
      } else if(c == 'x') {
    379c:	07a78863          	beq	a5,s10,380c <vprintf+0xf2>
      } else if(c == 'p') {
    37a0:	09b78463          	beq	a5,s11,3828 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    37a4:	07300713          	li	a4,115
    37a8:	0ce78663          	beq	a5,a4,3874 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    37ac:	06300713          	li	a4,99
    37b0:	0ee78e63          	beq	a5,a4,38ac <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    37b4:	11478863          	beq	a5,s4,38c4 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    37b8:	85d2                	mv	a1,s4
    37ba:	8556                	mv	a0,s5
    37bc:	00000097          	auipc	ra,0x0
    37c0:	e92080e7          	jalr	-366(ra) # 364e <putc>
        putc(fd, c);
    37c4:	85ca                	mv	a1,s2
    37c6:	8556                	mv	a0,s5
    37c8:	00000097          	auipc	ra,0x0
    37cc:	e86080e7          	jalr	-378(ra) # 364e <putc>
      }
      state = 0;
    37d0:	4981                	li	s3,0
    37d2:	b765                	j	377a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    37d4:	008b0913          	addi	s2,s6,8
    37d8:	4685                	li	a3,1
    37da:	4629                	li	a2,10
    37dc:	000b2583          	lw	a1,0(s6)
    37e0:	8556                	mv	a0,s5
    37e2:	00000097          	auipc	ra,0x0
    37e6:	e8e080e7          	jalr	-370(ra) # 3670 <printint>
    37ea:	8b4a                	mv	s6,s2
      state = 0;
    37ec:	4981                	li	s3,0
    37ee:	b771                	j	377a <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    37f0:	008b0913          	addi	s2,s6,8
    37f4:	4681                	li	a3,0
    37f6:	4629                	li	a2,10
    37f8:	000b2583          	lw	a1,0(s6)
    37fc:	8556                	mv	a0,s5
    37fe:	00000097          	auipc	ra,0x0
    3802:	e72080e7          	jalr	-398(ra) # 3670 <printint>
    3806:	8b4a                	mv	s6,s2
      state = 0;
    3808:	4981                	li	s3,0
    380a:	bf85                	j	377a <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    380c:	008b0913          	addi	s2,s6,8
    3810:	4681                	li	a3,0
    3812:	4641                	li	a2,16
    3814:	000b2583          	lw	a1,0(s6)
    3818:	8556                	mv	a0,s5
    381a:	00000097          	auipc	ra,0x0
    381e:	e56080e7          	jalr	-426(ra) # 3670 <printint>
    3822:	8b4a                	mv	s6,s2
      state = 0;
    3824:	4981                	li	s3,0
    3826:	bf91                	j	377a <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    3828:	008b0793          	addi	a5,s6,8
    382c:	f8f43423          	sd	a5,-120(s0)
    3830:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    3834:	03000593          	li	a1,48
    3838:	8556                	mv	a0,s5
    383a:	00000097          	auipc	ra,0x0
    383e:	e14080e7          	jalr	-492(ra) # 364e <putc>
  putc(fd, 'x');
    3842:	85ea                	mv	a1,s10
    3844:	8556                	mv	a0,s5
    3846:	00000097          	auipc	ra,0x0
    384a:	e08080e7          	jalr	-504(ra) # 364e <putc>
    384e:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3850:	03c9d793          	srli	a5,s3,0x3c
    3854:	97de                	add	a5,a5,s7
    3856:	0007c583          	lbu	a1,0(a5)
    385a:	8556                	mv	a0,s5
    385c:	00000097          	auipc	ra,0x0
    3860:	df2080e7          	jalr	-526(ra) # 364e <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    3864:	0992                	slli	s3,s3,0x4
    3866:	397d                	addiw	s2,s2,-1
    3868:	fe0914e3          	bnez	s2,3850 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    386c:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    3870:	4981                	li	s3,0
    3872:	b721                	j	377a <vprintf+0x60>
        s = va_arg(ap, char*);
    3874:	008b0993          	addi	s3,s6,8
    3878:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    387c:	02090163          	beqz	s2,389e <vprintf+0x184>
        while(*s != 0){
    3880:	00094583          	lbu	a1,0(s2)
    3884:	c9a1                	beqz	a1,38d4 <vprintf+0x1ba>
          putc(fd, *s);
    3886:	8556                	mv	a0,s5
    3888:	00000097          	auipc	ra,0x0
    388c:	dc6080e7          	jalr	-570(ra) # 364e <putc>
          s++;
    3890:	0905                	addi	s2,s2,1
        while(*s != 0){
    3892:	00094583          	lbu	a1,0(s2)
    3896:	f9e5                	bnez	a1,3886 <vprintf+0x16c>
        s = va_arg(ap, char*);
    3898:	8b4e                	mv	s6,s3
      state = 0;
    389a:	4981                	li	s3,0
    389c:	bdf9                	j	377a <vprintf+0x60>
          s = "(null)";
    389e:	00000917          	auipc	s2,0x0
    38a2:	26a90913          	addi	s2,s2,618 # 3b08 <malloc+0x124>
        while(*s != 0){
    38a6:	02800593          	li	a1,40
    38aa:	bff1                	j	3886 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    38ac:	008b0913          	addi	s2,s6,8
    38b0:	000b4583          	lbu	a1,0(s6)
    38b4:	8556                	mv	a0,s5
    38b6:	00000097          	auipc	ra,0x0
    38ba:	d98080e7          	jalr	-616(ra) # 364e <putc>
    38be:	8b4a                	mv	s6,s2
      state = 0;
    38c0:	4981                	li	s3,0
    38c2:	bd65                	j	377a <vprintf+0x60>
        putc(fd, c);
    38c4:	85d2                	mv	a1,s4
    38c6:	8556                	mv	a0,s5
    38c8:	00000097          	auipc	ra,0x0
    38cc:	d86080e7          	jalr	-634(ra) # 364e <putc>
      state = 0;
    38d0:	4981                	li	s3,0
    38d2:	b565                	j	377a <vprintf+0x60>
        s = va_arg(ap, char*);
    38d4:	8b4e                	mv	s6,s3
      state = 0;
    38d6:	4981                	li	s3,0
    38d8:	b54d                	j	377a <vprintf+0x60>
    }
  }
}
    38da:	70e6                	ld	ra,120(sp)
    38dc:	7446                	ld	s0,112(sp)
    38de:	74a6                	ld	s1,104(sp)
    38e0:	7906                	ld	s2,96(sp)
    38e2:	69e6                	ld	s3,88(sp)
    38e4:	6a46                	ld	s4,80(sp)
    38e6:	6aa6                	ld	s5,72(sp)
    38e8:	6b06                	ld	s6,64(sp)
    38ea:	7be2                	ld	s7,56(sp)
    38ec:	7c42                	ld	s8,48(sp)
    38ee:	7ca2                	ld	s9,40(sp)
    38f0:	7d02                	ld	s10,32(sp)
    38f2:	6de2                	ld	s11,24(sp)
    38f4:	6109                	addi	sp,sp,128
    38f6:	8082                	ret

00000000000038f8 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    38f8:	715d                	addi	sp,sp,-80
    38fa:	ec06                	sd	ra,24(sp)
    38fc:	e822                	sd	s0,16(sp)
    38fe:	1000                	addi	s0,sp,32
    3900:	e010                	sd	a2,0(s0)
    3902:	e414                	sd	a3,8(s0)
    3904:	e818                	sd	a4,16(s0)
    3906:	ec1c                	sd	a5,24(s0)
    3908:	03043023          	sd	a6,32(s0)
    390c:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    3910:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    3914:	8622                	mv	a2,s0
    3916:	00000097          	auipc	ra,0x0
    391a:	e04080e7          	jalr	-508(ra) # 371a <vprintf>
}
    391e:	60e2                	ld	ra,24(sp)
    3920:	6442                	ld	s0,16(sp)
    3922:	6161                	addi	sp,sp,80
    3924:	8082                	ret

0000000000003926 <printf>:

void
printf(const char *fmt, ...)
{
    3926:	711d                	addi	sp,sp,-96
    3928:	ec06                	sd	ra,24(sp)
    392a:	e822                	sd	s0,16(sp)
    392c:	1000                	addi	s0,sp,32
    392e:	e40c                	sd	a1,8(s0)
    3930:	e810                	sd	a2,16(s0)
    3932:	ec14                	sd	a3,24(s0)
    3934:	f018                	sd	a4,32(s0)
    3936:	f41c                	sd	a5,40(s0)
    3938:	03043823          	sd	a6,48(s0)
    393c:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    3940:	00840613          	addi	a2,s0,8
    3944:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    3948:	85aa                	mv	a1,a0
    394a:	4505                	li	a0,1
    394c:	00000097          	auipc	ra,0x0
    3950:	dce080e7          	jalr	-562(ra) # 371a <vprintf>
}
    3954:	60e2                	ld	ra,24(sp)
    3956:	6442                	ld	s0,16(sp)
    3958:	6125                	addi	sp,sp,96
    395a:	8082                	ret

000000000000395c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    395c:	1141                	addi	sp,sp,-16
    395e:	e422                	sd	s0,8(sp)
    3960:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3962:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3966:	00000797          	auipc	a5,0x0
    396a:	69a7b783          	ld	a5,1690(a5) # 4000 <freep>
    396e:	a805                	j	399e <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3970:	4618                	lw	a4,8(a2)
    3972:	9db9                	addw	a1,a1,a4
    3974:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    3978:	6398                	ld	a4,0(a5)
    397a:	6318                	ld	a4,0(a4)
    397c:	fee53823          	sd	a4,-16(a0)
    3980:	a091                	j	39c4 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    3982:	ff852703          	lw	a4,-8(a0)
    3986:	9e39                	addw	a2,a2,a4
    3988:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    398a:	ff053703          	ld	a4,-16(a0)
    398e:	e398                	sd	a4,0(a5)
    3990:	a099                	j	39d6 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3992:	6398                	ld	a4,0(a5)
    3994:	00e7e463          	bltu	a5,a4,399c <free+0x40>
    3998:	00e6ea63          	bltu	a3,a4,39ac <free+0x50>
{
    399c:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    399e:	fed7fae3          	bgeu	a5,a3,3992 <free+0x36>
    39a2:	6398                	ld	a4,0(a5)
    39a4:	00e6e463          	bltu	a3,a4,39ac <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    39a8:	fee7eae3          	bltu	a5,a4,399c <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    39ac:	ff852583          	lw	a1,-8(a0)
    39b0:	6390                	ld	a2,0(a5)
    39b2:	02059713          	slli	a4,a1,0x20
    39b6:	9301                	srli	a4,a4,0x20
    39b8:	0712                	slli	a4,a4,0x4
    39ba:	9736                	add	a4,a4,a3
    39bc:	fae60ae3          	beq	a2,a4,3970 <free+0x14>
    bp->s.ptr = p->s.ptr;
    39c0:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    39c4:	4790                	lw	a2,8(a5)
    39c6:	02061713          	slli	a4,a2,0x20
    39ca:	9301                	srli	a4,a4,0x20
    39cc:	0712                	slli	a4,a4,0x4
    39ce:	973e                	add	a4,a4,a5
    39d0:	fae689e3          	beq	a3,a4,3982 <free+0x26>
  } else
    p->s.ptr = bp;
    39d4:	e394                	sd	a3,0(a5)
  freep = p;
    39d6:	00000717          	auipc	a4,0x0
    39da:	62f73523          	sd	a5,1578(a4) # 4000 <freep>
}
    39de:	6422                	ld	s0,8(sp)
    39e0:	0141                	addi	sp,sp,16
    39e2:	8082                	ret

00000000000039e4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    39e4:	7139                	addi	sp,sp,-64
    39e6:	fc06                	sd	ra,56(sp)
    39e8:	f822                	sd	s0,48(sp)
    39ea:	f426                	sd	s1,40(sp)
    39ec:	f04a                	sd	s2,32(sp)
    39ee:	ec4e                	sd	s3,24(sp)
    39f0:	e852                	sd	s4,16(sp)
    39f2:	e456                	sd	s5,8(sp)
    39f4:	e05a                	sd	s6,0(sp)
    39f6:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    39f8:	02051493          	slli	s1,a0,0x20
    39fc:	9081                	srli	s1,s1,0x20
    39fe:	04bd                	addi	s1,s1,15
    3a00:	8091                	srli	s1,s1,0x4
    3a02:	0014899b          	addiw	s3,s1,1
    3a06:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    3a08:	00000517          	auipc	a0,0x0
    3a0c:	5f853503          	ld	a0,1528(a0) # 4000 <freep>
    3a10:	c515                	beqz	a0,3a3c <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3a12:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3a14:	4798                	lw	a4,8(a5)
    3a16:	02977f63          	bgeu	a4,s1,3a54 <malloc+0x70>
    3a1a:	8a4e                	mv	s4,s3
    3a1c:	0009871b          	sext.w	a4,s3
    3a20:	6685                	lui	a3,0x1
    3a22:	00d77363          	bgeu	a4,a3,3a28 <malloc+0x44>
    3a26:	6a05                	lui	s4,0x1
    3a28:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    3a2c:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3a30:	00000917          	auipc	s2,0x0
    3a34:	5d090913          	addi	s2,s2,1488 # 4000 <freep>
  if(p == (char*)-1)
    3a38:	5afd                	li	s5,-1
    3a3a:	a88d                	j	3aac <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    3a3c:	00001797          	auipc	a5,0x1
    3a40:	9d478793          	addi	a5,a5,-1580 # 4410 <base>
    3a44:	00000717          	auipc	a4,0x0
    3a48:	5af73e23          	sd	a5,1468(a4) # 4000 <freep>
    3a4c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    3a4e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    3a52:	b7e1                	j	3a1a <malloc+0x36>
      if(p->s.size == nunits)
    3a54:	02e48b63          	beq	s1,a4,3a8a <malloc+0xa6>
        p->s.size -= nunits;
    3a58:	4137073b          	subw	a4,a4,s3
    3a5c:	c798                	sw	a4,8(a5)
        p += p->s.size;
    3a5e:	1702                	slli	a4,a4,0x20
    3a60:	9301                	srli	a4,a4,0x20
    3a62:	0712                	slli	a4,a4,0x4
    3a64:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    3a66:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    3a6a:	00000717          	auipc	a4,0x0
    3a6e:	58a73b23          	sd	a0,1430(a4) # 4000 <freep>
      return (void*)(p + 1);
    3a72:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3a76:	70e2                	ld	ra,56(sp)
    3a78:	7442                	ld	s0,48(sp)
    3a7a:	74a2                	ld	s1,40(sp)
    3a7c:	7902                	ld	s2,32(sp)
    3a7e:	69e2                	ld	s3,24(sp)
    3a80:	6a42                	ld	s4,16(sp)
    3a82:	6aa2                	ld	s5,8(sp)
    3a84:	6b02                	ld	s6,0(sp)
    3a86:	6121                	addi	sp,sp,64
    3a88:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    3a8a:	6398                	ld	a4,0(a5)
    3a8c:	e118                	sd	a4,0(a0)
    3a8e:	bff1                	j	3a6a <malloc+0x86>
  hp->s.size = nu;
    3a90:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    3a94:	0541                	addi	a0,a0,16
    3a96:	00000097          	auipc	ra,0x0
    3a9a:	ec6080e7          	jalr	-314(ra) # 395c <free>
  return freep;
    3a9e:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    3aa2:	d971                	beqz	a0,3a76 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3aa4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3aa6:	4798                	lw	a4,8(a5)
    3aa8:	fa9776e3          	bgeu	a4,s1,3a54 <malloc+0x70>
    if(p == freep)
    3aac:	00093703          	ld	a4,0(s2)
    3ab0:	853e                	mv	a0,a5
    3ab2:	fef719e3          	bne	a4,a5,3aa4 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3ab6:	8552                	mv	a0,s4
    3ab8:	00000097          	auipc	ra,0x0
    3abc:	b56080e7          	jalr	-1194(ra) # 360e <sbrk>
  if(p == (char*)-1)
    3ac0:	fd5518e3          	bne	a0,s5,3a90 <malloc+0xac>
        return 0;
    3ac4:	4501                	li	a0,0
    3ac6:	bf45                	j	3a76 <malloc+0x92>
