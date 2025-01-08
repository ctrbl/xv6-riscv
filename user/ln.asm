
user/_ln:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <main>:
#include "kernel/stat.h"
#include "user/user.h"

int
main(int argc, char *argv[])
{
    3000:	1101                	addi	sp,sp,-32
    3002:	ec06                	sd	ra,24(sp)
    3004:	e822                	sd	s0,16(sp)
    3006:	e426                	sd	s1,8(sp)
    3008:	1000                	addi	s0,sp,32
  if(argc != 3){
    300a:	478d                	li	a5,3
    300c:	02f50063          	beq	a0,a5,302c <main+0x2c>
    fprintf(2, "Usage: ln old new\n");
    3010:	00001597          	auipc	a1,0x1
    3014:	88058593          	addi	a1,a1,-1920 # 3890 <malloc+0xea>
    3018:	4509                	li	a0,2
    301a:	00000097          	auipc	ra,0x0
    301e:	6a0080e7          	jalr	1696(ra) # 36ba <fprintf>
    exit(1);
    3022:	4505                	li	a0,1
    3024:	00000097          	auipc	ra,0x0
    3028:	31c080e7          	jalr	796(ra) # 3340 <exit>
    302c:	84ae                	mv	s1,a1
  }
  if(link(argv[1], argv[2]) < 0)
    302e:	698c                	ld	a1,16(a1)
    3030:	6488                	ld	a0,8(s1)
    3032:	00000097          	auipc	ra,0x0
    3036:	376080e7          	jalr	886(ra) # 33a8 <link>
    303a:	00054763          	bltz	a0,3048 <main+0x48>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit(0);
    303e:	4501                	li	a0,0
    3040:	00000097          	auipc	ra,0x0
    3044:	300080e7          	jalr	768(ra) # 3340 <exit>
    fprintf(2, "link %s %s: failed\n", argv[1], argv[2]);
    3048:	6894                	ld	a3,16(s1)
    304a:	6490                	ld	a2,8(s1)
    304c:	00001597          	auipc	a1,0x1
    3050:	85c58593          	addi	a1,a1,-1956 # 38a8 <malloc+0x102>
    3054:	4509                	li	a0,2
    3056:	00000097          	auipc	ra,0x0
    305a:	664080e7          	jalr	1636(ra) # 36ba <fprintf>
    305e:	b7c5                	j	303e <main+0x3e>

0000000000003060 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    3060:	1141                	addi	sp,sp,-16
    3062:	e406                	sd	ra,8(sp)
    3064:	e022                	sd	s0,0(sp)
    3066:	0800                	addi	s0,sp,16
  extern int main();
  main();
    3068:	00000097          	auipc	ra,0x0
    306c:	f98080e7          	jalr	-104(ra) # 3000 <main>
  exit(0);
    3070:	4501                	li	a0,0
    3072:	00000097          	auipc	ra,0x0
    3076:	2ce080e7          	jalr	718(ra) # 3340 <exit>

000000000000307a <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    307a:	1141                	addi	sp,sp,-16
    307c:	e422                	sd	s0,8(sp)
    307e:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3080:	87aa                	mv	a5,a0
    3082:	0585                	addi	a1,a1,1
    3084:	0785                	addi	a5,a5,1
    3086:	fff5c703          	lbu	a4,-1(a1)
    308a:	fee78fa3          	sb	a4,-1(a5)
    308e:	fb75                	bnez	a4,3082 <strcpy+0x8>
    ;
  return os;
}
    3090:	6422                	ld	s0,8(sp)
    3092:	0141                	addi	sp,sp,16
    3094:	8082                	ret

0000000000003096 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3096:	1141                	addi	sp,sp,-16
    3098:	e422                	sd	s0,8(sp)
    309a:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    309c:	00054783          	lbu	a5,0(a0)
    30a0:	cb91                	beqz	a5,30b4 <strcmp+0x1e>
    30a2:	0005c703          	lbu	a4,0(a1)
    30a6:	00f71763          	bne	a4,a5,30b4 <strcmp+0x1e>
    p++, q++;
    30aa:	0505                	addi	a0,a0,1
    30ac:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    30ae:	00054783          	lbu	a5,0(a0)
    30b2:	fbe5                	bnez	a5,30a2 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    30b4:	0005c503          	lbu	a0,0(a1)
}
    30b8:	40a7853b          	subw	a0,a5,a0
    30bc:	6422                	ld	s0,8(sp)
    30be:	0141                	addi	sp,sp,16
    30c0:	8082                	ret

00000000000030c2 <strlen>:

uint
strlen(const char *s)
{
    30c2:	1141                	addi	sp,sp,-16
    30c4:	e422                	sd	s0,8(sp)
    30c6:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    30c8:	00054783          	lbu	a5,0(a0)
    30cc:	cf91                	beqz	a5,30e8 <strlen+0x26>
    30ce:	0505                	addi	a0,a0,1
    30d0:	87aa                	mv	a5,a0
    30d2:	4685                	li	a3,1
    30d4:	9e89                	subw	a3,a3,a0
    30d6:	00f6853b          	addw	a0,a3,a5
    30da:	0785                	addi	a5,a5,1
    30dc:	fff7c703          	lbu	a4,-1(a5)
    30e0:	fb7d                	bnez	a4,30d6 <strlen+0x14>
    ;
  return n;
}
    30e2:	6422                	ld	s0,8(sp)
    30e4:	0141                	addi	sp,sp,16
    30e6:	8082                	ret
  for(n = 0; s[n]; n++)
    30e8:	4501                	li	a0,0
    30ea:	bfe5                	j	30e2 <strlen+0x20>

00000000000030ec <memset>:

void*
memset(void *dst, int c, uint n)
{
    30ec:	1141                	addi	sp,sp,-16
    30ee:	e422                	sd	s0,8(sp)
    30f0:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    30f2:	ca19                	beqz	a2,3108 <memset+0x1c>
    30f4:	87aa                	mv	a5,a0
    30f6:	1602                	slli	a2,a2,0x20
    30f8:	9201                	srli	a2,a2,0x20
    30fa:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    30fe:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    3102:	0785                	addi	a5,a5,1
    3104:	fee79de3          	bne	a5,a4,30fe <memset+0x12>
  }
  return dst;
}
    3108:	6422                	ld	s0,8(sp)
    310a:	0141                	addi	sp,sp,16
    310c:	8082                	ret

000000000000310e <strchr>:

char*
strchr(const char *s, char c)
{
    310e:	1141                	addi	sp,sp,-16
    3110:	e422                	sd	s0,8(sp)
    3112:	0800                	addi	s0,sp,16
  for(; *s; s++)
    3114:	00054783          	lbu	a5,0(a0)
    3118:	cb99                	beqz	a5,312e <strchr+0x20>
    if(*s == c)
    311a:	00f58763          	beq	a1,a5,3128 <strchr+0x1a>
  for(; *s; s++)
    311e:	0505                	addi	a0,a0,1
    3120:	00054783          	lbu	a5,0(a0)
    3124:	fbfd                	bnez	a5,311a <strchr+0xc>
      return (char*)s;
  return 0;
    3126:	4501                	li	a0,0
}
    3128:	6422                	ld	s0,8(sp)
    312a:	0141                	addi	sp,sp,16
    312c:	8082                	ret
  return 0;
    312e:	4501                	li	a0,0
    3130:	bfe5                	j	3128 <strchr+0x1a>

0000000000003132 <gets>:

char*
gets(char *buf, int max)
{
    3132:	711d                	addi	sp,sp,-96
    3134:	ec86                	sd	ra,88(sp)
    3136:	e8a2                	sd	s0,80(sp)
    3138:	e4a6                	sd	s1,72(sp)
    313a:	e0ca                	sd	s2,64(sp)
    313c:	fc4e                	sd	s3,56(sp)
    313e:	f852                	sd	s4,48(sp)
    3140:	f456                	sd	s5,40(sp)
    3142:	f05a                	sd	s6,32(sp)
    3144:	ec5e                	sd	s7,24(sp)
    3146:	1080                	addi	s0,sp,96
    3148:	8baa                	mv	s7,a0
    314a:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    314c:	892a                	mv	s2,a0
    314e:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    3150:	4aa9                	li	s5,10
    3152:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    3154:	89a6                	mv	s3,s1
    3156:	2485                	addiw	s1,s1,1
    3158:	0344d863          	bge	s1,s4,3188 <gets+0x56>
    cc = read(0, &c, 1);
    315c:	4605                	li	a2,1
    315e:	faf40593          	addi	a1,s0,-81
    3162:	4501                	li	a0,0
    3164:	00000097          	auipc	ra,0x0
    3168:	1fc080e7          	jalr	508(ra) # 3360 <read>
    if(cc < 1)
    316c:	00a05e63          	blez	a0,3188 <gets+0x56>
    buf[i++] = c;
    3170:	faf44783          	lbu	a5,-81(s0)
    3174:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    3178:	01578763          	beq	a5,s5,3186 <gets+0x54>
    317c:	0905                	addi	s2,s2,1
    317e:	fd679be3          	bne	a5,s6,3154 <gets+0x22>
  for(i=0; i+1 < max; ){
    3182:	89a6                	mv	s3,s1
    3184:	a011                	j	3188 <gets+0x56>
    3186:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    3188:	99de                	add	s3,s3,s7
    318a:	00098023          	sb	zero,0(s3)
  return buf;
}
    318e:	855e                	mv	a0,s7
    3190:	60e6                	ld	ra,88(sp)
    3192:	6446                	ld	s0,80(sp)
    3194:	64a6                	ld	s1,72(sp)
    3196:	6906                	ld	s2,64(sp)
    3198:	79e2                	ld	s3,56(sp)
    319a:	7a42                	ld	s4,48(sp)
    319c:	7aa2                	ld	s5,40(sp)
    319e:	7b02                	ld	s6,32(sp)
    31a0:	6be2                	ld	s7,24(sp)
    31a2:	6125                	addi	sp,sp,96
    31a4:	8082                	ret

00000000000031a6 <stat>:

int
stat(const char *n, struct stat *st)
{
    31a6:	1101                	addi	sp,sp,-32
    31a8:	ec06                	sd	ra,24(sp)
    31aa:	e822                	sd	s0,16(sp)
    31ac:	e426                	sd	s1,8(sp)
    31ae:	e04a                	sd	s2,0(sp)
    31b0:	1000                	addi	s0,sp,32
    31b2:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    31b4:	4581                	li	a1,0
    31b6:	00000097          	auipc	ra,0x0
    31ba:	1d2080e7          	jalr	466(ra) # 3388 <open>
  if(fd < 0)
    31be:	02054563          	bltz	a0,31e8 <stat+0x42>
    31c2:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    31c4:	85ca                	mv	a1,s2
    31c6:	00000097          	auipc	ra,0x0
    31ca:	1da080e7          	jalr	474(ra) # 33a0 <fstat>
    31ce:	892a                	mv	s2,a0
  close(fd);
    31d0:	8526                	mv	a0,s1
    31d2:	00000097          	auipc	ra,0x0
    31d6:	19e080e7          	jalr	414(ra) # 3370 <close>
  return r;
}
    31da:	854a                	mv	a0,s2
    31dc:	60e2                	ld	ra,24(sp)
    31de:	6442                	ld	s0,16(sp)
    31e0:	64a2                	ld	s1,8(sp)
    31e2:	6902                	ld	s2,0(sp)
    31e4:	6105                	addi	sp,sp,32
    31e6:	8082                	ret
    return -1;
    31e8:	597d                	li	s2,-1
    31ea:	bfc5                	j	31da <stat+0x34>

00000000000031ec <atoi>:

int
atoi(const char *s)
{
    31ec:	1141                	addi	sp,sp,-16
    31ee:	e422                	sd	s0,8(sp)
    31f0:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    31f2:	00054603          	lbu	a2,0(a0)
    31f6:	fd06079b          	addiw	a5,a2,-48
    31fa:	0ff7f793          	andi	a5,a5,255
    31fe:	4725                	li	a4,9
    3200:	02f76963          	bltu	a4,a5,3232 <atoi+0x46>
    3204:	86aa                	mv	a3,a0
  n = 0;
    3206:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    3208:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    320a:	0685                	addi	a3,a3,1
    320c:	0025179b          	slliw	a5,a0,0x2
    3210:	9fa9                	addw	a5,a5,a0
    3212:	0017979b          	slliw	a5,a5,0x1
    3216:	9fb1                	addw	a5,a5,a2
    3218:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    321c:	0006c603          	lbu	a2,0(a3)
    3220:	fd06071b          	addiw	a4,a2,-48
    3224:	0ff77713          	andi	a4,a4,255
    3228:	fee5f1e3          	bgeu	a1,a4,320a <atoi+0x1e>
  return n;
}
    322c:	6422                	ld	s0,8(sp)
    322e:	0141                	addi	sp,sp,16
    3230:	8082                	ret
  n = 0;
    3232:	4501                	li	a0,0
    3234:	bfe5                	j	322c <atoi+0x40>

0000000000003236 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3236:	1141                	addi	sp,sp,-16
    3238:	e422                	sd	s0,8(sp)
    323a:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    323c:	02b57463          	bgeu	a0,a1,3264 <memmove+0x2e>
    while(n-- > 0)
    3240:	00c05f63          	blez	a2,325e <memmove+0x28>
    3244:	1602                	slli	a2,a2,0x20
    3246:	9201                	srli	a2,a2,0x20
    3248:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    324c:	872a                	mv	a4,a0
      *dst++ = *src++;
    324e:	0585                	addi	a1,a1,1
    3250:	0705                	addi	a4,a4,1
    3252:	fff5c683          	lbu	a3,-1(a1)
    3256:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    325a:	fee79ae3          	bne	a5,a4,324e <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    325e:	6422                	ld	s0,8(sp)
    3260:	0141                	addi	sp,sp,16
    3262:	8082                	ret
    dst += n;
    3264:	00c50733          	add	a4,a0,a2
    src += n;
    3268:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    326a:	fec05ae3          	blez	a2,325e <memmove+0x28>
    326e:	fff6079b          	addiw	a5,a2,-1
    3272:	1782                	slli	a5,a5,0x20
    3274:	9381                	srli	a5,a5,0x20
    3276:	fff7c793          	not	a5,a5
    327a:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    327c:	15fd                	addi	a1,a1,-1
    327e:	177d                	addi	a4,a4,-1
    3280:	0005c683          	lbu	a3,0(a1)
    3284:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    3288:	fee79ae3          	bne	a5,a4,327c <memmove+0x46>
    328c:	bfc9                	j	325e <memmove+0x28>

000000000000328e <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    328e:	1141                	addi	sp,sp,-16
    3290:	e422                	sd	s0,8(sp)
    3292:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    3294:	ca05                	beqz	a2,32c4 <memcmp+0x36>
    3296:	fff6069b          	addiw	a3,a2,-1
    329a:	1682                	slli	a3,a3,0x20
    329c:	9281                	srli	a3,a3,0x20
    329e:	0685                	addi	a3,a3,1
    32a0:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    32a2:	00054783          	lbu	a5,0(a0)
    32a6:	0005c703          	lbu	a4,0(a1)
    32aa:	00e79863          	bne	a5,a4,32ba <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    32ae:	0505                	addi	a0,a0,1
    p2++;
    32b0:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    32b2:	fed518e3          	bne	a0,a3,32a2 <memcmp+0x14>
  }
  return 0;
    32b6:	4501                	li	a0,0
    32b8:	a019                	j	32be <memcmp+0x30>
      return *p1 - *p2;
    32ba:	40e7853b          	subw	a0,a5,a4
}
    32be:	6422                	ld	s0,8(sp)
    32c0:	0141                	addi	sp,sp,16
    32c2:	8082                	ret
  return 0;
    32c4:	4501                	li	a0,0
    32c6:	bfe5                	j	32be <memcmp+0x30>

00000000000032c8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    32c8:	1141                	addi	sp,sp,-16
    32ca:	e406                	sd	ra,8(sp)
    32cc:	e022                	sd	s0,0(sp)
    32ce:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    32d0:	00000097          	auipc	ra,0x0
    32d4:	f66080e7          	jalr	-154(ra) # 3236 <memmove>
}
    32d8:	60a2                	ld	ra,8(sp)
    32da:	6402                	ld	s0,0(sp)
    32dc:	0141                	addi	sp,sp,16
    32de:	8082                	ret

00000000000032e0 <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    32e0:	1141                	addi	sp,sp,-16
    32e2:	e422                	sd	s0,8(sp)
    32e4:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    32e6:	00052023          	sw	zero,0(a0)
}  
    32ea:	6422                	ld	s0,8(sp)
    32ec:	0141                	addi	sp,sp,16
    32ee:	8082                	ret

00000000000032f0 <lock>:

void lock(struct spinlock * lk) 
{    
    32f0:	1141                	addi	sp,sp,-16
    32f2:	e422                	sd	s0,8(sp)
    32f4:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    32f6:	4705                	li	a4,1
    32f8:	87ba                	mv	a5,a4
    32fa:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    32fe:	2781                	sext.w	a5,a5
    3300:	ffe5                	bnez	a5,32f8 <lock+0x8>
}  
    3302:	6422                	ld	s0,8(sp)
    3304:	0141                	addi	sp,sp,16
    3306:	8082                	ret

0000000000003308 <unlock>:

void unlock(struct spinlock * lk) 
{   
    3308:	1141                	addi	sp,sp,-16
    330a:	e422                	sd	s0,8(sp)
    330c:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    330e:	0f50000f          	fence	iorw,ow
    3312:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    3316:	6422                	ld	s0,8(sp)
    3318:	0141                	addi	sp,sp,16
    331a:	8082                	ret

000000000000331c <isDigit>:

unsigned int isDigit(char *c) {
    331c:	1141                	addi	sp,sp,-16
    331e:	e422                	sd	s0,8(sp)
    3320:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    3322:	00054503          	lbu	a0,0(a0)
    3326:	fd05051b          	addiw	a0,a0,-48
    332a:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    332e:	00a53513          	sltiu	a0,a0,10
    3332:	6422                	ld	s0,8(sp)
    3334:	0141                	addi	sp,sp,16
    3336:	8082                	ret

0000000000003338 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    3338:	4885                	li	a7,1
 ecall
    333a:	00000073          	ecall
 ret
    333e:	8082                	ret

0000000000003340 <exit>:
.global exit
exit:
 li a7, SYS_exit
    3340:	4889                	li	a7,2
 ecall
    3342:	00000073          	ecall
 ret
    3346:	8082                	ret

0000000000003348 <wait>:
.global wait
wait:
 li a7, SYS_wait
    3348:	488d                	li	a7,3
 ecall
    334a:	00000073          	ecall
 ret
    334e:	8082                	ret

0000000000003350 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    3350:	48e1                	li	a7,24
 ecall
    3352:	00000073          	ecall
 ret
    3356:	8082                	ret

0000000000003358 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    3358:	4891                	li	a7,4
 ecall
    335a:	00000073          	ecall
 ret
    335e:	8082                	ret

0000000000003360 <read>:
.global read
read:
 li a7, SYS_read
    3360:	4895                	li	a7,5
 ecall
    3362:	00000073          	ecall
 ret
    3366:	8082                	ret

0000000000003368 <write>:
.global write
write:
 li a7, SYS_write
    3368:	48c1                	li	a7,16
 ecall
    336a:	00000073          	ecall
 ret
    336e:	8082                	ret

0000000000003370 <close>:
.global close
close:
 li a7, SYS_close
    3370:	48d5                	li	a7,21
 ecall
    3372:	00000073          	ecall
 ret
    3376:	8082                	ret

0000000000003378 <kill>:
.global kill
kill:
 li a7, SYS_kill
    3378:	4899                	li	a7,6
 ecall
    337a:	00000073          	ecall
 ret
    337e:	8082                	ret

0000000000003380 <exec>:
.global exec
exec:
 li a7, SYS_exec
    3380:	489d                	li	a7,7
 ecall
    3382:	00000073          	ecall
 ret
    3386:	8082                	ret

0000000000003388 <open>:
.global open
open:
 li a7, SYS_open
    3388:	48bd                	li	a7,15
 ecall
    338a:	00000073          	ecall
 ret
    338e:	8082                	ret

0000000000003390 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    3390:	48c5                	li	a7,17
 ecall
    3392:	00000073          	ecall
 ret
    3396:	8082                	ret

0000000000003398 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    3398:	48c9                	li	a7,18
 ecall
    339a:	00000073          	ecall
 ret
    339e:	8082                	ret

00000000000033a0 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    33a0:	48a1                	li	a7,8
 ecall
    33a2:	00000073          	ecall
 ret
    33a6:	8082                	ret

00000000000033a8 <link>:
.global link
link:
 li a7, SYS_link
    33a8:	48cd                	li	a7,19
 ecall
    33aa:	00000073          	ecall
 ret
    33ae:	8082                	ret

00000000000033b0 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    33b0:	48d1                	li	a7,20
 ecall
    33b2:	00000073          	ecall
 ret
    33b6:	8082                	ret

00000000000033b8 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    33b8:	48a5                	li	a7,9
 ecall
    33ba:	00000073          	ecall
 ret
    33be:	8082                	ret

00000000000033c0 <dup>:
.global dup
dup:
 li a7, SYS_dup
    33c0:	48a9                	li	a7,10
 ecall
    33c2:	00000073          	ecall
 ret
    33c6:	8082                	ret

00000000000033c8 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    33c8:	48ad                	li	a7,11
 ecall
    33ca:	00000073          	ecall
 ret
    33ce:	8082                	ret

00000000000033d0 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    33d0:	48b1                	li	a7,12
 ecall
    33d2:	00000073          	ecall
 ret
    33d6:	8082                	ret

00000000000033d8 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    33d8:	48b5                	li	a7,13
 ecall
    33da:	00000073          	ecall
 ret
    33de:	8082                	ret

00000000000033e0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    33e0:	48b9                	li	a7,14
 ecall
    33e2:	00000073          	ecall
 ret
    33e6:	8082                	ret

00000000000033e8 <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    33e8:	48d9                	li	a7,22
 ecall
    33ea:	00000073          	ecall
 ret
    33ee:	8082                	ret

00000000000033f0 <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    33f0:	48dd                	li	a7,23
 ecall
    33f2:	00000073          	ecall
 ret
    33f6:	8082                	ret

00000000000033f8 <ps>:
.global ps
ps:
 li a7, SYS_ps
    33f8:	48e5                	li	a7,25
 ecall
    33fa:	00000073          	ecall
 ret
    33fe:	8082                	ret

0000000000003400 <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    3400:	48e9                	li	a7,26
 ecall
    3402:	00000073          	ecall
 ret
    3406:	8082                	ret

0000000000003408 <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    3408:	48ed                	li	a7,27
 ecall
    340a:	00000073          	ecall
 ret
    340e:	8082                	ret

0000000000003410 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    3410:	1101                	addi	sp,sp,-32
    3412:	ec06                	sd	ra,24(sp)
    3414:	e822                	sd	s0,16(sp)
    3416:	1000                	addi	s0,sp,32
    3418:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    341c:	4605                	li	a2,1
    341e:	fef40593          	addi	a1,s0,-17
    3422:	00000097          	auipc	ra,0x0
    3426:	f46080e7          	jalr	-186(ra) # 3368 <write>
}
    342a:	60e2                	ld	ra,24(sp)
    342c:	6442                	ld	s0,16(sp)
    342e:	6105                	addi	sp,sp,32
    3430:	8082                	ret

0000000000003432 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3432:	7139                	addi	sp,sp,-64
    3434:	fc06                	sd	ra,56(sp)
    3436:	f822                	sd	s0,48(sp)
    3438:	f426                	sd	s1,40(sp)
    343a:	f04a                	sd	s2,32(sp)
    343c:	ec4e                	sd	s3,24(sp)
    343e:	0080                	addi	s0,sp,64
    3440:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3442:	c299                	beqz	a3,3448 <printint+0x16>
    3444:	0805c863          	bltz	a1,34d4 <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3448:	2581                	sext.w	a1,a1
  neg = 0;
    344a:	4881                	li	a7,0
    344c:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    3450:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    3452:	2601                	sext.w	a2,a2
    3454:	00000517          	auipc	a0,0x0
    3458:	47450513          	addi	a0,a0,1140 # 38c8 <digits>
    345c:	883a                	mv	a6,a4
    345e:	2705                	addiw	a4,a4,1
    3460:	02c5f7bb          	remuw	a5,a1,a2
    3464:	1782                	slli	a5,a5,0x20
    3466:	9381                	srli	a5,a5,0x20
    3468:	97aa                	add	a5,a5,a0
    346a:	0007c783          	lbu	a5,0(a5)
    346e:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    3472:	0005879b          	sext.w	a5,a1
    3476:	02c5d5bb          	divuw	a1,a1,a2
    347a:	0685                	addi	a3,a3,1
    347c:	fec7f0e3          	bgeu	a5,a2,345c <printint+0x2a>
  if(neg)
    3480:	00088b63          	beqz	a7,3496 <printint+0x64>
    buf[i++] = '-';
    3484:	fd040793          	addi	a5,s0,-48
    3488:	973e                	add	a4,a4,a5
    348a:	02d00793          	li	a5,45
    348e:	fef70823          	sb	a5,-16(a4)
    3492:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    3496:	02e05863          	blez	a4,34c6 <printint+0x94>
    349a:	fc040793          	addi	a5,s0,-64
    349e:	00e78933          	add	s2,a5,a4
    34a2:	fff78993          	addi	s3,a5,-1
    34a6:	99ba                	add	s3,s3,a4
    34a8:	377d                	addiw	a4,a4,-1
    34aa:	1702                	slli	a4,a4,0x20
    34ac:	9301                	srli	a4,a4,0x20
    34ae:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    34b2:	fff94583          	lbu	a1,-1(s2)
    34b6:	8526                	mv	a0,s1
    34b8:	00000097          	auipc	ra,0x0
    34bc:	f58080e7          	jalr	-168(ra) # 3410 <putc>
  while(--i >= 0)
    34c0:	197d                	addi	s2,s2,-1
    34c2:	ff3918e3          	bne	s2,s3,34b2 <printint+0x80>
}
    34c6:	70e2                	ld	ra,56(sp)
    34c8:	7442                	ld	s0,48(sp)
    34ca:	74a2                	ld	s1,40(sp)
    34cc:	7902                	ld	s2,32(sp)
    34ce:	69e2                	ld	s3,24(sp)
    34d0:	6121                	addi	sp,sp,64
    34d2:	8082                	ret
    x = -xx;
    34d4:	40b005bb          	negw	a1,a1
    neg = 1;
    34d8:	4885                	li	a7,1
    x = -xx;
    34da:	bf8d                	j	344c <printint+0x1a>

00000000000034dc <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    34dc:	7119                	addi	sp,sp,-128
    34de:	fc86                	sd	ra,120(sp)
    34e0:	f8a2                	sd	s0,112(sp)
    34e2:	f4a6                	sd	s1,104(sp)
    34e4:	f0ca                	sd	s2,96(sp)
    34e6:	ecce                	sd	s3,88(sp)
    34e8:	e8d2                	sd	s4,80(sp)
    34ea:	e4d6                	sd	s5,72(sp)
    34ec:	e0da                	sd	s6,64(sp)
    34ee:	fc5e                	sd	s7,56(sp)
    34f0:	f862                	sd	s8,48(sp)
    34f2:	f466                	sd	s9,40(sp)
    34f4:	f06a                	sd	s10,32(sp)
    34f6:	ec6e                	sd	s11,24(sp)
    34f8:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    34fa:	0005c903          	lbu	s2,0(a1)
    34fe:	18090f63          	beqz	s2,369c <vprintf+0x1c0>
    3502:	8aaa                	mv	s5,a0
    3504:	8b32                	mv	s6,a2
    3506:	00158493          	addi	s1,a1,1
  state = 0;
    350a:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    350c:	02500a13          	li	s4,37
      if(c == 'd'){
    3510:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    3514:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    3518:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    351c:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3520:	00000b97          	auipc	s7,0x0
    3524:	3a8b8b93          	addi	s7,s7,936 # 38c8 <digits>
    3528:	a839                	j	3546 <vprintf+0x6a>
        putc(fd, c);
    352a:	85ca                	mv	a1,s2
    352c:	8556                	mv	a0,s5
    352e:	00000097          	auipc	ra,0x0
    3532:	ee2080e7          	jalr	-286(ra) # 3410 <putc>
    3536:	a019                	j	353c <vprintf+0x60>
    } else if(state == '%'){
    3538:	01498f63          	beq	s3,s4,3556 <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    353c:	0485                	addi	s1,s1,1
    353e:	fff4c903          	lbu	s2,-1(s1)
    3542:	14090d63          	beqz	s2,369c <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    3546:	0009079b          	sext.w	a5,s2
    if(state == 0){
    354a:	fe0997e3          	bnez	s3,3538 <vprintf+0x5c>
      if(c == '%'){
    354e:	fd479ee3          	bne	a5,s4,352a <vprintf+0x4e>
        state = '%';
    3552:	89be                	mv	s3,a5
    3554:	b7e5                	j	353c <vprintf+0x60>
      if(c == 'd'){
    3556:	05878063          	beq	a5,s8,3596 <vprintf+0xba>
      } else if(c == 'l') {
    355a:	05978c63          	beq	a5,s9,35b2 <vprintf+0xd6>
      } else if(c == 'x') {
    355e:	07a78863          	beq	a5,s10,35ce <vprintf+0xf2>
      } else if(c == 'p') {
    3562:	09b78463          	beq	a5,s11,35ea <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    3566:	07300713          	li	a4,115
    356a:	0ce78663          	beq	a5,a4,3636 <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    356e:	06300713          	li	a4,99
    3572:	0ee78e63          	beq	a5,a4,366e <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    3576:	11478863          	beq	a5,s4,3686 <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    357a:	85d2                	mv	a1,s4
    357c:	8556                	mv	a0,s5
    357e:	00000097          	auipc	ra,0x0
    3582:	e92080e7          	jalr	-366(ra) # 3410 <putc>
        putc(fd, c);
    3586:	85ca                	mv	a1,s2
    3588:	8556                	mv	a0,s5
    358a:	00000097          	auipc	ra,0x0
    358e:	e86080e7          	jalr	-378(ra) # 3410 <putc>
      }
      state = 0;
    3592:	4981                	li	s3,0
    3594:	b765                	j	353c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    3596:	008b0913          	addi	s2,s6,8
    359a:	4685                	li	a3,1
    359c:	4629                	li	a2,10
    359e:	000b2583          	lw	a1,0(s6)
    35a2:	8556                	mv	a0,s5
    35a4:	00000097          	auipc	ra,0x0
    35a8:	e8e080e7          	jalr	-370(ra) # 3432 <printint>
    35ac:	8b4a                	mv	s6,s2
      state = 0;
    35ae:	4981                	li	s3,0
    35b0:	b771                	j	353c <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    35b2:	008b0913          	addi	s2,s6,8
    35b6:	4681                	li	a3,0
    35b8:	4629                	li	a2,10
    35ba:	000b2583          	lw	a1,0(s6)
    35be:	8556                	mv	a0,s5
    35c0:	00000097          	auipc	ra,0x0
    35c4:	e72080e7          	jalr	-398(ra) # 3432 <printint>
    35c8:	8b4a                	mv	s6,s2
      state = 0;
    35ca:	4981                	li	s3,0
    35cc:	bf85                	j	353c <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    35ce:	008b0913          	addi	s2,s6,8
    35d2:	4681                	li	a3,0
    35d4:	4641                	li	a2,16
    35d6:	000b2583          	lw	a1,0(s6)
    35da:	8556                	mv	a0,s5
    35dc:	00000097          	auipc	ra,0x0
    35e0:	e56080e7          	jalr	-426(ra) # 3432 <printint>
    35e4:	8b4a                	mv	s6,s2
      state = 0;
    35e6:	4981                	li	s3,0
    35e8:	bf91                	j	353c <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    35ea:	008b0793          	addi	a5,s6,8
    35ee:	f8f43423          	sd	a5,-120(s0)
    35f2:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    35f6:	03000593          	li	a1,48
    35fa:	8556                	mv	a0,s5
    35fc:	00000097          	auipc	ra,0x0
    3600:	e14080e7          	jalr	-492(ra) # 3410 <putc>
  putc(fd, 'x');
    3604:	85ea                	mv	a1,s10
    3606:	8556                	mv	a0,s5
    3608:	00000097          	auipc	ra,0x0
    360c:	e08080e7          	jalr	-504(ra) # 3410 <putc>
    3610:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    3612:	03c9d793          	srli	a5,s3,0x3c
    3616:	97de                	add	a5,a5,s7
    3618:	0007c583          	lbu	a1,0(a5)
    361c:	8556                	mv	a0,s5
    361e:	00000097          	auipc	ra,0x0
    3622:	df2080e7          	jalr	-526(ra) # 3410 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    3626:	0992                	slli	s3,s3,0x4
    3628:	397d                	addiw	s2,s2,-1
    362a:	fe0914e3          	bnez	s2,3612 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    362e:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    3632:	4981                	li	s3,0
    3634:	b721                	j	353c <vprintf+0x60>
        s = va_arg(ap, char*);
    3636:	008b0993          	addi	s3,s6,8
    363a:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    363e:	02090163          	beqz	s2,3660 <vprintf+0x184>
        while(*s != 0){
    3642:	00094583          	lbu	a1,0(s2)
    3646:	c9a1                	beqz	a1,3696 <vprintf+0x1ba>
          putc(fd, *s);
    3648:	8556                	mv	a0,s5
    364a:	00000097          	auipc	ra,0x0
    364e:	dc6080e7          	jalr	-570(ra) # 3410 <putc>
          s++;
    3652:	0905                	addi	s2,s2,1
        while(*s != 0){
    3654:	00094583          	lbu	a1,0(s2)
    3658:	f9e5                	bnez	a1,3648 <vprintf+0x16c>
        s = va_arg(ap, char*);
    365a:	8b4e                	mv	s6,s3
      state = 0;
    365c:	4981                	li	s3,0
    365e:	bdf9                	j	353c <vprintf+0x60>
          s = "(null)";
    3660:	00000917          	auipc	s2,0x0
    3664:	26090913          	addi	s2,s2,608 # 38c0 <malloc+0x11a>
        while(*s != 0){
    3668:	02800593          	li	a1,40
    366c:	bff1                	j	3648 <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    366e:	008b0913          	addi	s2,s6,8
    3672:	000b4583          	lbu	a1,0(s6)
    3676:	8556                	mv	a0,s5
    3678:	00000097          	auipc	ra,0x0
    367c:	d98080e7          	jalr	-616(ra) # 3410 <putc>
    3680:	8b4a                	mv	s6,s2
      state = 0;
    3682:	4981                	li	s3,0
    3684:	bd65                	j	353c <vprintf+0x60>
        putc(fd, c);
    3686:	85d2                	mv	a1,s4
    3688:	8556                	mv	a0,s5
    368a:	00000097          	auipc	ra,0x0
    368e:	d86080e7          	jalr	-634(ra) # 3410 <putc>
      state = 0;
    3692:	4981                	li	s3,0
    3694:	b565                	j	353c <vprintf+0x60>
        s = va_arg(ap, char*);
    3696:	8b4e                	mv	s6,s3
      state = 0;
    3698:	4981                	li	s3,0
    369a:	b54d                	j	353c <vprintf+0x60>
    }
  }
}
    369c:	70e6                	ld	ra,120(sp)
    369e:	7446                	ld	s0,112(sp)
    36a0:	74a6                	ld	s1,104(sp)
    36a2:	7906                	ld	s2,96(sp)
    36a4:	69e6                	ld	s3,88(sp)
    36a6:	6a46                	ld	s4,80(sp)
    36a8:	6aa6                	ld	s5,72(sp)
    36aa:	6b06                	ld	s6,64(sp)
    36ac:	7be2                	ld	s7,56(sp)
    36ae:	7c42                	ld	s8,48(sp)
    36b0:	7ca2                	ld	s9,40(sp)
    36b2:	7d02                	ld	s10,32(sp)
    36b4:	6de2                	ld	s11,24(sp)
    36b6:	6109                	addi	sp,sp,128
    36b8:	8082                	ret

00000000000036ba <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    36ba:	715d                	addi	sp,sp,-80
    36bc:	ec06                	sd	ra,24(sp)
    36be:	e822                	sd	s0,16(sp)
    36c0:	1000                	addi	s0,sp,32
    36c2:	e010                	sd	a2,0(s0)
    36c4:	e414                	sd	a3,8(s0)
    36c6:	e818                	sd	a4,16(s0)
    36c8:	ec1c                	sd	a5,24(s0)
    36ca:	03043023          	sd	a6,32(s0)
    36ce:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    36d2:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    36d6:	8622                	mv	a2,s0
    36d8:	00000097          	auipc	ra,0x0
    36dc:	e04080e7          	jalr	-508(ra) # 34dc <vprintf>
}
    36e0:	60e2                	ld	ra,24(sp)
    36e2:	6442                	ld	s0,16(sp)
    36e4:	6161                	addi	sp,sp,80
    36e6:	8082                	ret

00000000000036e8 <printf>:

void
printf(const char *fmt, ...)
{
    36e8:	711d                	addi	sp,sp,-96
    36ea:	ec06                	sd	ra,24(sp)
    36ec:	e822                	sd	s0,16(sp)
    36ee:	1000                	addi	s0,sp,32
    36f0:	e40c                	sd	a1,8(s0)
    36f2:	e810                	sd	a2,16(s0)
    36f4:	ec14                	sd	a3,24(s0)
    36f6:	f018                	sd	a4,32(s0)
    36f8:	f41c                	sd	a5,40(s0)
    36fa:	03043823          	sd	a6,48(s0)
    36fe:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    3702:	00840613          	addi	a2,s0,8
    3706:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    370a:	85aa                	mv	a1,a0
    370c:	4505                	li	a0,1
    370e:	00000097          	auipc	ra,0x0
    3712:	dce080e7          	jalr	-562(ra) # 34dc <vprintf>
}
    3716:	60e2                	ld	ra,24(sp)
    3718:	6442                	ld	s0,16(sp)
    371a:	6125                	addi	sp,sp,96
    371c:	8082                	ret

000000000000371e <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    371e:	1141                	addi	sp,sp,-16
    3720:	e422                	sd	s0,8(sp)
    3722:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3724:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3728:	00001797          	auipc	a5,0x1
    372c:	8d87b783          	ld	a5,-1832(a5) # 4000 <freep>
    3730:	a805                	j	3760 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3732:	4618                	lw	a4,8(a2)
    3734:	9db9                	addw	a1,a1,a4
    3736:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    373a:	6398                	ld	a4,0(a5)
    373c:	6318                	ld	a4,0(a4)
    373e:	fee53823          	sd	a4,-16(a0)
    3742:	a091                	j	3786 <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    3744:	ff852703          	lw	a4,-8(a0)
    3748:	9e39                	addw	a2,a2,a4
    374a:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    374c:	ff053703          	ld	a4,-16(a0)
    3750:	e398                	sd	a4,0(a5)
    3752:	a099                	j	3798 <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3754:	6398                	ld	a4,0(a5)
    3756:	00e7e463          	bltu	a5,a4,375e <free+0x40>
    375a:	00e6ea63          	bltu	a3,a4,376e <free+0x50>
{
    375e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3760:	fed7fae3          	bgeu	a5,a3,3754 <free+0x36>
    3764:	6398                	ld	a4,0(a5)
    3766:	00e6e463          	bltu	a3,a4,376e <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    376a:	fee7eae3          	bltu	a5,a4,375e <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    376e:	ff852583          	lw	a1,-8(a0)
    3772:	6390                	ld	a2,0(a5)
    3774:	02059713          	slli	a4,a1,0x20
    3778:	9301                	srli	a4,a4,0x20
    377a:	0712                	slli	a4,a4,0x4
    377c:	9736                	add	a4,a4,a3
    377e:	fae60ae3          	beq	a2,a4,3732 <free+0x14>
    bp->s.ptr = p->s.ptr;
    3782:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    3786:	4790                	lw	a2,8(a5)
    3788:	02061713          	slli	a4,a2,0x20
    378c:	9301                	srli	a4,a4,0x20
    378e:	0712                	slli	a4,a4,0x4
    3790:	973e                	add	a4,a4,a5
    3792:	fae689e3          	beq	a3,a4,3744 <free+0x26>
  } else
    p->s.ptr = bp;
    3796:	e394                	sd	a3,0(a5)
  freep = p;
    3798:	00001717          	auipc	a4,0x1
    379c:	86f73423          	sd	a5,-1944(a4) # 4000 <freep>
}
    37a0:	6422                	ld	s0,8(sp)
    37a2:	0141                	addi	sp,sp,16
    37a4:	8082                	ret

00000000000037a6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    37a6:	7139                	addi	sp,sp,-64
    37a8:	fc06                	sd	ra,56(sp)
    37aa:	f822                	sd	s0,48(sp)
    37ac:	f426                	sd	s1,40(sp)
    37ae:	f04a                	sd	s2,32(sp)
    37b0:	ec4e                	sd	s3,24(sp)
    37b2:	e852                	sd	s4,16(sp)
    37b4:	e456                	sd	s5,8(sp)
    37b6:	e05a                	sd	s6,0(sp)
    37b8:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    37ba:	02051493          	slli	s1,a0,0x20
    37be:	9081                	srli	s1,s1,0x20
    37c0:	04bd                	addi	s1,s1,15
    37c2:	8091                	srli	s1,s1,0x4
    37c4:	0014899b          	addiw	s3,s1,1
    37c8:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    37ca:	00001517          	auipc	a0,0x1
    37ce:	83653503          	ld	a0,-1994(a0) # 4000 <freep>
    37d2:	c515                	beqz	a0,37fe <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    37d4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    37d6:	4798                	lw	a4,8(a5)
    37d8:	02977f63          	bgeu	a4,s1,3816 <malloc+0x70>
    37dc:	8a4e                	mv	s4,s3
    37de:	0009871b          	sext.w	a4,s3
    37e2:	6685                	lui	a3,0x1
    37e4:	00d77363          	bgeu	a4,a3,37ea <malloc+0x44>
    37e8:	6a05                	lui	s4,0x1
    37ea:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    37ee:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    37f2:	00001917          	auipc	s2,0x1
    37f6:	80e90913          	addi	s2,s2,-2034 # 4000 <freep>
  if(p == (char*)-1)
    37fa:	5afd                	li	s5,-1
    37fc:	a88d                	j	386e <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    37fe:	00001797          	auipc	a5,0x1
    3802:	81278793          	addi	a5,a5,-2030 # 4010 <base>
    3806:	00000717          	auipc	a4,0x0
    380a:	7ef73d23          	sd	a5,2042(a4) # 4000 <freep>
    380e:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    3810:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    3814:	b7e1                	j	37dc <malloc+0x36>
      if(p->s.size == nunits)
    3816:	02e48b63          	beq	s1,a4,384c <malloc+0xa6>
        p->s.size -= nunits;
    381a:	4137073b          	subw	a4,a4,s3
    381e:	c798                	sw	a4,8(a5)
        p += p->s.size;
    3820:	1702                	slli	a4,a4,0x20
    3822:	9301                	srli	a4,a4,0x20
    3824:	0712                	slli	a4,a4,0x4
    3826:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    3828:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    382c:	00000717          	auipc	a4,0x0
    3830:	7ca73a23          	sd	a0,2004(a4) # 4000 <freep>
      return (void*)(p + 1);
    3834:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3838:	70e2                	ld	ra,56(sp)
    383a:	7442                	ld	s0,48(sp)
    383c:	74a2                	ld	s1,40(sp)
    383e:	7902                	ld	s2,32(sp)
    3840:	69e2                	ld	s3,24(sp)
    3842:	6a42                	ld	s4,16(sp)
    3844:	6aa2                	ld	s5,8(sp)
    3846:	6b02                	ld	s6,0(sp)
    3848:	6121                	addi	sp,sp,64
    384a:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    384c:	6398                	ld	a4,0(a5)
    384e:	e118                	sd	a4,0(a0)
    3850:	bff1                	j	382c <malloc+0x86>
  hp->s.size = nu;
    3852:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    3856:	0541                	addi	a0,a0,16
    3858:	00000097          	auipc	ra,0x0
    385c:	ec6080e7          	jalr	-314(ra) # 371e <free>
  return freep;
    3860:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    3864:	d971                	beqz	a0,3838 <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3866:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    3868:	4798                	lw	a4,8(a5)
    386a:	fa9776e3          	bgeu	a4,s1,3816 <malloc+0x70>
    if(p == freep)
    386e:	00093703          	ld	a4,0(s2)
    3872:	853e                	mv	a0,a5
    3874:	fef719e3          	bne	a4,a5,3866 <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    3878:	8552                	mv	a0,s4
    387a:	00000097          	auipc	ra,0x0
    387e:	b56080e7          	jalr	-1194(ra) # 33d0 <sbrk>
  if(p == (char*)-1)
    3882:	fd5518e3          	bne	a0,s5,3852 <malloc+0xac>
        return 0;
    3886:	4501                	li	a0,0
    3888:	bf45                	j	3838 <malloc+0x92>
