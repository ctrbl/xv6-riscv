
user/_sh:     file format elf64-littleriscv


Disassembly of section .text:

0000000000003000 <getcmd>:
  exit(0);
}

int
getcmd(char *buf, int nbuf)
{
    3000:	1101                	addi	sp,sp,-32
    3002:	ec06                	sd	ra,24(sp)
    3004:	e822                	sd	s0,16(sp)
    3006:	e426                	sd	s1,8(sp)
    3008:	e04a                	sd	s2,0(sp)
    300a:	1000                	addi	s0,sp,32
    300c:	84aa                	mv	s1,a0
    300e:	892e                	mv	s2,a1
  write(2, "$ ", 2);
    3010:	4609                	li	a2,2
    3012:	00001597          	auipc	a1,0x1
    3016:	36e58593          	addi	a1,a1,878 # 4380 <malloc+0xe4>
    301a:	4509                	li	a0,2
    301c:	00001097          	auipc	ra,0x1
    3020:	e42080e7          	jalr	-446(ra) # 3e5e <write>
  memset(buf, 0, nbuf);
    3024:	864a                	mv	a2,s2
    3026:	4581                	li	a1,0
    3028:	8526                	mv	a0,s1
    302a:	00001097          	auipc	ra,0x1
    302e:	bb8080e7          	jalr	-1096(ra) # 3be2 <memset>
  gets(buf, nbuf);
    3032:	85ca                	mv	a1,s2
    3034:	8526                	mv	a0,s1
    3036:	00001097          	auipc	ra,0x1
    303a:	bf2080e7          	jalr	-1038(ra) # 3c28 <gets>
  if(buf[0] == 0) // EOF
    303e:	0004c503          	lbu	a0,0(s1)
    3042:	00153513          	seqz	a0,a0
    return -1;
  return 0;
}
    3046:	40a00533          	neg	a0,a0
    304a:	60e2                	ld	ra,24(sp)
    304c:	6442                	ld	s0,16(sp)
    304e:	64a2                	ld	s1,8(sp)
    3050:	6902                	ld	s2,0(sp)
    3052:	6105                	addi	sp,sp,32
    3054:	8082                	ret

0000000000003056 <panic>:
  exit(0);
}

void
panic(char *s)
{
    3056:	1141                	addi	sp,sp,-16
    3058:	e406                	sd	ra,8(sp)
    305a:	e022                	sd	s0,0(sp)
    305c:	0800                	addi	s0,sp,16
    305e:	862a                	mv	a2,a0
  fprintf(2, "%s\n", s);
    3060:	00001597          	auipc	a1,0x1
    3064:	32858593          	addi	a1,a1,808 # 4388 <malloc+0xec>
    3068:	4509                	li	a0,2
    306a:	00001097          	auipc	ra,0x1
    306e:	146080e7          	jalr	326(ra) # 41b0 <fprintf>
  exit(1);
    3072:	4505                	li	a0,1
    3074:	00001097          	auipc	ra,0x1
    3078:	dc2080e7          	jalr	-574(ra) # 3e36 <exit>

000000000000307c <fork1>:
}

int
fork1(void)
{
    307c:	1141                	addi	sp,sp,-16
    307e:	e406                	sd	ra,8(sp)
    3080:	e022                	sd	s0,0(sp)
    3082:	0800                	addi	s0,sp,16
  int pid;

  pid = fork();
    3084:	00001097          	auipc	ra,0x1
    3088:	daa080e7          	jalr	-598(ra) # 3e2e <fork>
  if(pid == -1)
    308c:	57fd                	li	a5,-1
    308e:	00f50663          	beq	a0,a5,309a <fork1+0x1e>
    panic("fork");
  return pid;
}
    3092:	60a2                	ld	ra,8(sp)
    3094:	6402                	ld	s0,0(sp)
    3096:	0141                	addi	sp,sp,16
    3098:	8082                	ret
    panic("fork");
    309a:	00001517          	auipc	a0,0x1
    309e:	2f650513          	addi	a0,a0,758 # 4390 <malloc+0xf4>
    30a2:	00000097          	auipc	ra,0x0
    30a6:	fb4080e7          	jalr	-76(ra) # 3056 <panic>

00000000000030aa <runcmd>:
{
    30aa:	7179                	addi	sp,sp,-48
    30ac:	f406                	sd	ra,40(sp)
    30ae:	f022                	sd	s0,32(sp)
    30b0:	ec26                	sd	s1,24(sp)
    30b2:	1800                	addi	s0,sp,48
  if(cmd == 0)
    30b4:	c10d                	beqz	a0,30d6 <runcmd+0x2c>
    30b6:	84aa                	mv	s1,a0
  switch(cmd->type){
    30b8:	4118                	lw	a4,0(a0)
    30ba:	4795                	li	a5,5
    30bc:	02e7e263          	bltu	a5,a4,30e0 <runcmd+0x36>
    30c0:	00056783          	lwu	a5,0(a0)
    30c4:	078a                	slli	a5,a5,0x2
    30c6:	00001717          	auipc	a4,0x1
    30ca:	3ca70713          	addi	a4,a4,970 # 4490 <malloc+0x1f4>
    30ce:	97ba                	add	a5,a5,a4
    30d0:	439c                	lw	a5,0(a5)
    30d2:	97ba                	add	a5,a5,a4
    30d4:	8782                	jr	a5
    exit(1);
    30d6:	4505                	li	a0,1
    30d8:	00001097          	auipc	ra,0x1
    30dc:	d5e080e7          	jalr	-674(ra) # 3e36 <exit>
    panic("runcmd");
    30e0:	00001517          	auipc	a0,0x1
    30e4:	2b850513          	addi	a0,a0,696 # 4398 <malloc+0xfc>
    30e8:	00000097          	auipc	ra,0x0
    30ec:	f6e080e7          	jalr	-146(ra) # 3056 <panic>
    if(ecmd->argv[0] == 0)
    30f0:	6508                	ld	a0,8(a0)
    30f2:	c515                	beqz	a0,311e <runcmd+0x74>
    exec(ecmd->argv[0], ecmd->argv);
    30f4:	00848593          	addi	a1,s1,8
    30f8:	00001097          	auipc	ra,0x1
    30fc:	d7e080e7          	jalr	-642(ra) # 3e76 <exec>
    fprintf(2, "exec %s failed\n", ecmd->argv[0]);
    3100:	6490                	ld	a2,8(s1)
    3102:	00001597          	auipc	a1,0x1
    3106:	29e58593          	addi	a1,a1,670 # 43a0 <malloc+0x104>
    310a:	4509                	li	a0,2
    310c:	00001097          	auipc	ra,0x1
    3110:	0a4080e7          	jalr	164(ra) # 41b0 <fprintf>
  exit(0);
    3114:	4501                	li	a0,0
    3116:	00001097          	auipc	ra,0x1
    311a:	d20080e7          	jalr	-736(ra) # 3e36 <exit>
      exit(1);
    311e:	4505                	li	a0,1
    3120:	00001097          	auipc	ra,0x1
    3124:	d16080e7          	jalr	-746(ra) # 3e36 <exit>
    close(rcmd->fd);
    3128:	5148                	lw	a0,36(a0)
    312a:	00001097          	auipc	ra,0x1
    312e:	d3c080e7          	jalr	-708(ra) # 3e66 <close>
    if(open(rcmd->file, rcmd->mode) < 0){
    3132:	508c                	lw	a1,32(s1)
    3134:	6888                	ld	a0,16(s1)
    3136:	00001097          	auipc	ra,0x1
    313a:	d48080e7          	jalr	-696(ra) # 3e7e <open>
    313e:	00054763          	bltz	a0,314c <runcmd+0xa2>
    runcmd(rcmd->cmd);
    3142:	6488                	ld	a0,8(s1)
    3144:	00000097          	auipc	ra,0x0
    3148:	f66080e7          	jalr	-154(ra) # 30aa <runcmd>
      fprintf(2, "open %s failed\n", rcmd->file);
    314c:	6890                	ld	a2,16(s1)
    314e:	00001597          	auipc	a1,0x1
    3152:	26258593          	addi	a1,a1,610 # 43b0 <malloc+0x114>
    3156:	4509                	li	a0,2
    3158:	00001097          	auipc	ra,0x1
    315c:	058080e7          	jalr	88(ra) # 41b0 <fprintf>
      exit(1);
    3160:	4505                	li	a0,1
    3162:	00001097          	auipc	ra,0x1
    3166:	cd4080e7          	jalr	-812(ra) # 3e36 <exit>
    if(fork1() == 0)
    316a:	00000097          	auipc	ra,0x0
    316e:	f12080e7          	jalr	-238(ra) # 307c <fork1>
    3172:	e511                	bnez	a0,317e <runcmd+0xd4>
      runcmd(lcmd->left);
    3174:	6488                	ld	a0,8(s1)
    3176:	00000097          	auipc	ra,0x0
    317a:	f34080e7          	jalr	-204(ra) # 30aa <runcmd>
    wait(0);
    317e:	4501                	li	a0,0
    3180:	00001097          	auipc	ra,0x1
    3184:	cbe080e7          	jalr	-834(ra) # 3e3e <wait>
    runcmd(lcmd->right);
    3188:	6888                	ld	a0,16(s1)
    318a:	00000097          	auipc	ra,0x0
    318e:	f20080e7          	jalr	-224(ra) # 30aa <runcmd>
    if(pipe(p) < 0)
    3192:	fd840513          	addi	a0,s0,-40
    3196:	00001097          	auipc	ra,0x1
    319a:	cb8080e7          	jalr	-840(ra) # 3e4e <pipe>
    319e:	04054363          	bltz	a0,31e4 <runcmd+0x13a>
    if(fork1() == 0){
    31a2:	00000097          	auipc	ra,0x0
    31a6:	eda080e7          	jalr	-294(ra) # 307c <fork1>
    31aa:	e529                	bnez	a0,31f4 <runcmd+0x14a>
      close(1);
    31ac:	4505                	li	a0,1
    31ae:	00001097          	auipc	ra,0x1
    31b2:	cb8080e7          	jalr	-840(ra) # 3e66 <close>
      dup(p[1]);
    31b6:	fdc42503          	lw	a0,-36(s0)
    31ba:	00001097          	auipc	ra,0x1
    31be:	cfc080e7          	jalr	-772(ra) # 3eb6 <dup>
      close(p[0]);
    31c2:	fd842503          	lw	a0,-40(s0)
    31c6:	00001097          	auipc	ra,0x1
    31ca:	ca0080e7          	jalr	-864(ra) # 3e66 <close>
      close(p[1]);
    31ce:	fdc42503          	lw	a0,-36(s0)
    31d2:	00001097          	auipc	ra,0x1
    31d6:	c94080e7          	jalr	-876(ra) # 3e66 <close>
      runcmd(pcmd->left);
    31da:	6488                	ld	a0,8(s1)
    31dc:	00000097          	auipc	ra,0x0
    31e0:	ece080e7          	jalr	-306(ra) # 30aa <runcmd>
      panic("pipe");
    31e4:	00001517          	auipc	a0,0x1
    31e8:	1dc50513          	addi	a0,a0,476 # 43c0 <malloc+0x124>
    31ec:	00000097          	auipc	ra,0x0
    31f0:	e6a080e7          	jalr	-406(ra) # 3056 <panic>
    if(fork1() == 0){
    31f4:	00000097          	auipc	ra,0x0
    31f8:	e88080e7          	jalr	-376(ra) # 307c <fork1>
    31fc:	ed05                	bnez	a0,3234 <runcmd+0x18a>
      close(0);
    31fe:	00001097          	auipc	ra,0x1
    3202:	c68080e7          	jalr	-920(ra) # 3e66 <close>
      dup(p[0]);
    3206:	fd842503          	lw	a0,-40(s0)
    320a:	00001097          	auipc	ra,0x1
    320e:	cac080e7          	jalr	-852(ra) # 3eb6 <dup>
      close(p[0]);
    3212:	fd842503          	lw	a0,-40(s0)
    3216:	00001097          	auipc	ra,0x1
    321a:	c50080e7          	jalr	-944(ra) # 3e66 <close>
      close(p[1]);
    321e:	fdc42503          	lw	a0,-36(s0)
    3222:	00001097          	auipc	ra,0x1
    3226:	c44080e7          	jalr	-956(ra) # 3e66 <close>
      runcmd(pcmd->right);
    322a:	6888                	ld	a0,16(s1)
    322c:	00000097          	auipc	ra,0x0
    3230:	e7e080e7          	jalr	-386(ra) # 30aa <runcmd>
    close(p[0]);
    3234:	fd842503          	lw	a0,-40(s0)
    3238:	00001097          	auipc	ra,0x1
    323c:	c2e080e7          	jalr	-978(ra) # 3e66 <close>
    close(p[1]);
    3240:	fdc42503          	lw	a0,-36(s0)
    3244:	00001097          	auipc	ra,0x1
    3248:	c22080e7          	jalr	-990(ra) # 3e66 <close>
    wait(0);
    324c:	4501                	li	a0,0
    324e:	00001097          	auipc	ra,0x1
    3252:	bf0080e7          	jalr	-1040(ra) # 3e3e <wait>
    wait(0);
    3256:	4501                	li	a0,0
    3258:	00001097          	auipc	ra,0x1
    325c:	be6080e7          	jalr	-1050(ra) # 3e3e <wait>
    break;
    3260:	bd55                	j	3114 <runcmd+0x6a>
    if(fork1() == 0)
    3262:	00000097          	auipc	ra,0x0
    3266:	e1a080e7          	jalr	-486(ra) # 307c <fork1>
    326a:	ea0515e3          	bnez	a0,3114 <runcmd+0x6a>
      runcmd(bcmd->cmd);
    326e:	6488                	ld	a0,8(s1)
    3270:	00000097          	auipc	ra,0x0
    3274:	e3a080e7          	jalr	-454(ra) # 30aa <runcmd>

0000000000003278 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
    3278:	1101                	addi	sp,sp,-32
    327a:	ec06                	sd	ra,24(sp)
    327c:	e822                	sd	s0,16(sp)
    327e:	e426                	sd	s1,8(sp)
    3280:	1000                	addi	s0,sp,32
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    3282:	14800513          	li	a0,328
    3286:	00001097          	auipc	ra,0x1
    328a:	016080e7          	jalr	22(ra) # 429c <malloc>
    328e:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
    3290:	14800613          	li	a2,328
    3294:	4581                	li	a1,0
    3296:	00001097          	auipc	ra,0x1
    329a:	94c080e7          	jalr	-1716(ra) # 3be2 <memset>
  cmd->type = EXEC;
    329e:	4785                	li	a5,1
    32a0:	c09c                	sw	a5,0(s1)
  return (struct cmd*)cmd;
}
    32a2:	8526                	mv	a0,s1
    32a4:	60e2                	ld	ra,24(sp)
    32a6:	6442                	ld	s0,16(sp)
    32a8:	64a2                	ld	s1,8(sp)
    32aa:	6105                	addi	sp,sp,32
    32ac:	8082                	ret

00000000000032ae <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
    32ae:	7139                	addi	sp,sp,-64
    32b0:	fc06                	sd	ra,56(sp)
    32b2:	f822                	sd	s0,48(sp)
    32b4:	f426                	sd	s1,40(sp)
    32b6:	f04a                	sd	s2,32(sp)
    32b8:	ec4e                	sd	s3,24(sp)
    32ba:	e852                	sd	s4,16(sp)
    32bc:	e456                	sd	s5,8(sp)
    32be:	e05a                	sd	s6,0(sp)
    32c0:	0080                	addi	s0,sp,64
    32c2:	8b2a                	mv	s6,a0
    32c4:	8aae                	mv	s5,a1
    32c6:	8a32                	mv	s4,a2
    32c8:	89b6                	mv	s3,a3
    32ca:	893a                	mv	s2,a4
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
    32cc:	02800513          	li	a0,40
    32d0:	00001097          	auipc	ra,0x1
    32d4:	fcc080e7          	jalr	-52(ra) # 429c <malloc>
    32d8:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
    32da:	02800613          	li	a2,40
    32de:	4581                	li	a1,0
    32e0:	00001097          	auipc	ra,0x1
    32e4:	902080e7          	jalr	-1790(ra) # 3be2 <memset>
  cmd->type = REDIR;
    32e8:	4789                	li	a5,2
    32ea:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
    32ec:	0164b423          	sd	s6,8(s1)
  cmd->file = file;
    32f0:	0154b823          	sd	s5,16(s1)
  cmd->efile = efile;
    32f4:	0144bc23          	sd	s4,24(s1)
  cmd->mode = mode;
    32f8:	0334a023          	sw	s3,32(s1)
  cmd->fd = fd;
    32fc:	0324a223          	sw	s2,36(s1)
  return (struct cmd*)cmd;
}
    3300:	8526                	mv	a0,s1
    3302:	70e2                	ld	ra,56(sp)
    3304:	7442                	ld	s0,48(sp)
    3306:	74a2                	ld	s1,40(sp)
    3308:	7902                	ld	s2,32(sp)
    330a:	69e2                	ld	s3,24(sp)
    330c:	6a42                	ld	s4,16(sp)
    330e:	6aa2                	ld	s5,8(sp)
    3310:	6b02                	ld	s6,0(sp)
    3312:	6121                	addi	sp,sp,64
    3314:	8082                	ret

0000000000003316 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
    3316:	7179                	addi	sp,sp,-48
    3318:	f406                	sd	ra,40(sp)
    331a:	f022                	sd	s0,32(sp)
    331c:	ec26                	sd	s1,24(sp)
    331e:	e84a                	sd	s2,16(sp)
    3320:	e44e                	sd	s3,8(sp)
    3322:	1800                	addi	s0,sp,48
    3324:	89aa                	mv	s3,a0
    3326:	892e                	mv	s2,a1
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
    3328:	4561                	li	a0,24
    332a:	00001097          	auipc	ra,0x1
    332e:	f72080e7          	jalr	-142(ra) # 429c <malloc>
    3332:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
    3334:	4661                	li	a2,24
    3336:	4581                	li	a1,0
    3338:	00001097          	auipc	ra,0x1
    333c:	8aa080e7          	jalr	-1878(ra) # 3be2 <memset>
  cmd->type = PIPE;
    3340:	478d                	li	a5,3
    3342:	c09c                	sw	a5,0(s1)
  cmd->left = left;
    3344:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
    3348:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
    334c:	8526                	mv	a0,s1
    334e:	70a2                	ld	ra,40(sp)
    3350:	7402                	ld	s0,32(sp)
    3352:	64e2                	ld	s1,24(sp)
    3354:	6942                	ld	s2,16(sp)
    3356:	69a2                	ld	s3,8(sp)
    3358:	6145                	addi	sp,sp,48
    335a:	8082                	ret

000000000000335c <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
    335c:	7179                	addi	sp,sp,-48
    335e:	f406                	sd	ra,40(sp)
    3360:	f022                	sd	s0,32(sp)
    3362:	ec26                	sd	s1,24(sp)
    3364:	e84a                	sd	s2,16(sp)
    3366:	e44e                	sd	s3,8(sp)
    3368:	1800                	addi	s0,sp,48
    336a:	89aa                	mv	s3,a0
    336c:	892e                	mv	s2,a1
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    336e:	4561                	li	a0,24
    3370:	00001097          	auipc	ra,0x1
    3374:	f2c080e7          	jalr	-212(ra) # 429c <malloc>
    3378:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
    337a:	4661                	li	a2,24
    337c:	4581                	li	a1,0
    337e:	00001097          	auipc	ra,0x1
    3382:	864080e7          	jalr	-1948(ra) # 3be2 <memset>
  cmd->type = LIST;
    3386:	4791                	li	a5,4
    3388:	c09c                	sw	a5,0(s1)
  cmd->left = left;
    338a:	0134b423          	sd	s3,8(s1)
  cmd->right = right;
    338e:	0124b823          	sd	s2,16(s1)
  return (struct cmd*)cmd;
}
    3392:	8526                	mv	a0,s1
    3394:	70a2                	ld	ra,40(sp)
    3396:	7402                	ld	s0,32(sp)
    3398:	64e2                	ld	s1,24(sp)
    339a:	6942                	ld	s2,16(sp)
    339c:	69a2                	ld	s3,8(sp)
    339e:	6145                	addi	sp,sp,48
    33a0:	8082                	ret

00000000000033a2 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
    33a2:	1101                	addi	sp,sp,-32
    33a4:	ec06                	sd	ra,24(sp)
    33a6:	e822                	sd	s0,16(sp)
    33a8:	e426                	sd	s1,8(sp)
    33aa:	e04a                	sd	s2,0(sp)
    33ac:	1000                	addi	s0,sp,32
    33ae:	892a                	mv	s2,a0
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
    33b0:	4541                	li	a0,16
    33b2:	00001097          	auipc	ra,0x1
    33b6:	eea080e7          	jalr	-278(ra) # 429c <malloc>
    33ba:	84aa                	mv	s1,a0
  memset(cmd, 0, sizeof(*cmd));
    33bc:	4641                	li	a2,16
    33be:	4581                	li	a1,0
    33c0:	00001097          	auipc	ra,0x1
    33c4:	822080e7          	jalr	-2014(ra) # 3be2 <memset>
  cmd->type = BACK;
    33c8:	4795                	li	a5,5
    33ca:	c09c                	sw	a5,0(s1)
  cmd->cmd = subcmd;
    33cc:	0124b423          	sd	s2,8(s1)
  return (struct cmd*)cmd;
}
    33d0:	8526                	mv	a0,s1
    33d2:	60e2                	ld	ra,24(sp)
    33d4:	6442                	ld	s0,16(sp)
    33d6:	64a2                	ld	s1,8(sp)
    33d8:	6902                	ld	s2,0(sp)
    33da:	6105                	addi	sp,sp,32
    33dc:	8082                	ret

00000000000033de <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
    33de:	7139                	addi	sp,sp,-64
    33e0:	fc06                	sd	ra,56(sp)
    33e2:	f822                	sd	s0,48(sp)
    33e4:	f426                	sd	s1,40(sp)
    33e6:	f04a                	sd	s2,32(sp)
    33e8:	ec4e                	sd	s3,24(sp)
    33ea:	e852                	sd	s4,16(sp)
    33ec:	e456                	sd	s5,8(sp)
    33ee:	e05a                	sd	s6,0(sp)
    33f0:	0080                	addi	s0,sp,64
    33f2:	8a2a                	mv	s4,a0
    33f4:	892e                	mv	s2,a1
    33f6:	8ab2                	mv	s5,a2
    33f8:	8b36                	mv	s6,a3
  char *s;
  int ret;

  s = *ps;
    33fa:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
    33fc:	00002997          	auipc	s3,0x2
    3400:	c0c98993          	addi	s3,s3,-1012 # 5008 <whitespace>
    3404:	00b4fd63          	bgeu	s1,a1,341e <gettoken+0x40>
    3408:	0004c583          	lbu	a1,0(s1)
    340c:	854e                	mv	a0,s3
    340e:	00000097          	auipc	ra,0x0
    3412:	7f6080e7          	jalr	2038(ra) # 3c04 <strchr>
    3416:	c501                	beqz	a0,341e <gettoken+0x40>
    s++;
    3418:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
    341a:	fe9917e3          	bne	s2,s1,3408 <gettoken+0x2a>
  if(q)
    341e:	000a8463          	beqz	s5,3426 <gettoken+0x48>
    *q = s;
    3422:	009ab023          	sd	s1,0(s5)
  ret = *s;
    3426:	0004c783          	lbu	a5,0(s1)
    342a:	00078a9b          	sext.w	s5,a5
  switch(*s){
    342e:	03c00713          	li	a4,60
    3432:	06f76563          	bltu	a4,a5,349c <gettoken+0xbe>
    3436:	03a00713          	li	a4,58
    343a:	00f76e63          	bltu	a4,a5,3456 <gettoken+0x78>
    343e:	cf89                	beqz	a5,3458 <gettoken+0x7a>
    3440:	02600713          	li	a4,38
    3444:	00e78963          	beq	a5,a4,3456 <gettoken+0x78>
    3448:	fd87879b          	addiw	a5,a5,-40
    344c:	0ff7f793          	andi	a5,a5,255
    3450:	4705                	li	a4,1
    3452:	06f76c63          	bltu	a4,a5,34ca <gettoken+0xec>
  case '(':
  case ')':
  case ';':
  case '&':
  case '<':
    s++;
    3456:	0485                	addi	s1,s1,1
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
    3458:	000b0463          	beqz	s6,3460 <gettoken+0x82>
    *eq = s;
    345c:	009b3023          	sd	s1,0(s6)

  while(s < es && strchr(whitespace, *s))
    3460:	00002997          	auipc	s3,0x2
    3464:	ba898993          	addi	s3,s3,-1112 # 5008 <whitespace>
    3468:	0124fd63          	bgeu	s1,s2,3482 <gettoken+0xa4>
    346c:	0004c583          	lbu	a1,0(s1)
    3470:	854e                	mv	a0,s3
    3472:	00000097          	auipc	ra,0x0
    3476:	792080e7          	jalr	1938(ra) # 3c04 <strchr>
    347a:	c501                	beqz	a0,3482 <gettoken+0xa4>
    s++;
    347c:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
    347e:	fe9917e3          	bne	s2,s1,346c <gettoken+0x8e>
  *ps = s;
    3482:	009a3023          	sd	s1,0(s4)
  return ret;
}
    3486:	8556                	mv	a0,s5
    3488:	70e2                	ld	ra,56(sp)
    348a:	7442                	ld	s0,48(sp)
    348c:	74a2                	ld	s1,40(sp)
    348e:	7902                	ld	s2,32(sp)
    3490:	69e2                	ld	s3,24(sp)
    3492:	6a42                	ld	s4,16(sp)
    3494:	6aa2                	ld	s5,8(sp)
    3496:	6b02                	ld	s6,0(sp)
    3498:	6121                	addi	sp,sp,64
    349a:	8082                	ret
  switch(*s){
    349c:	03e00713          	li	a4,62
    34a0:	02e79163          	bne	a5,a4,34c2 <gettoken+0xe4>
    s++;
    34a4:	00148693          	addi	a3,s1,1
    if(*s == '>'){
    34a8:	0014c703          	lbu	a4,1(s1)
    34ac:	03e00793          	li	a5,62
      s++;
    34b0:	0489                	addi	s1,s1,2
      ret = '+';
    34b2:	02b00a93          	li	s5,43
    if(*s == '>'){
    34b6:	faf701e3          	beq	a4,a5,3458 <gettoken+0x7a>
    s++;
    34ba:	84b6                	mv	s1,a3
  ret = *s;
    34bc:	03e00a93          	li	s5,62
    34c0:	bf61                	j	3458 <gettoken+0x7a>
  switch(*s){
    34c2:	07c00713          	li	a4,124
    34c6:	f8e788e3          	beq	a5,a4,3456 <gettoken+0x78>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
    34ca:	00002997          	auipc	s3,0x2
    34ce:	b3e98993          	addi	s3,s3,-1218 # 5008 <whitespace>
    34d2:	00002a97          	auipc	s5,0x2
    34d6:	b2ea8a93          	addi	s5,s5,-1234 # 5000 <symbols>
    34da:	0324f563          	bgeu	s1,s2,3504 <gettoken+0x126>
    34de:	0004c583          	lbu	a1,0(s1)
    34e2:	854e                	mv	a0,s3
    34e4:	00000097          	auipc	ra,0x0
    34e8:	720080e7          	jalr	1824(ra) # 3c04 <strchr>
    34ec:	e505                	bnez	a0,3514 <gettoken+0x136>
    34ee:	0004c583          	lbu	a1,0(s1)
    34f2:	8556                	mv	a0,s5
    34f4:	00000097          	auipc	ra,0x0
    34f8:	710080e7          	jalr	1808(ra) # 3c04 <strchr>
    34fc:	e909                	bnez	a0,350e <gettoken+0x130>
      s++;
    34fe:	0485                	addi	s1,s1,1
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
    3500:	fc991fe3          	bne	s2,s1,34de <gettoken+0x100>
  if(eq)
    3504:	06100a93          	li	s5,97
    3508:	f40b1ae3          	bnez	s6,345c <gettoken+0x7e>
    350c:	bf9d                	j	3482 <gettoken+0xa4>
    ret = 'a';
    350e:	06100a93          	li	s5,97
    3512:	b799                	j	3458 <gettoken+0x7a>
    3514:	06100a93          	li	s5,97
    3518:	b781                	j	3458 <gettoken+0x7a>

000000000000351a <peek>:

int
peek(char **ps, char *es, char *toks)
{
    351a:	7139                	addi	sp,sp,-64
    351c:	fc06                	sd	ra,56(sp)
    351e:	f822                	sd	s0,48(sp)
    3520:	f426                	sd	s1,40(sp)
    3522:	f04a                	sd	s2,32(sp)
    3524:	ec4e                	sd	s3,24(sp)
    3526:	e852                	sd	s4,16(sp)
    3528:	e456                	sd	s5,8(sp)
    352a:	0080                	addi	s0,sp,64
    352c:	8a2a                	mv	s4,a0
    352e:	892e                	mv	s2,a1
    3530:	8ab2                	mv	s5,a2
  char *s;

  s = *ps;
    3532:	6104                	ld	s1,0(a0)
  while(s < es && strchr(whitespace, *s))
    3534:	00002997          	auipc	s3,0x2
    3538:	ad498993          	addi	s3,s3,-1324 # 5008 <whitespace>
    353c:	00b4fd63          	bgeu	s1,a1,3556 <peek+0x3c>
    3540:	0004c583          	lbu	a1,0(s1)
    3544:	854e                	mv	a0,s3
    3546:	00000097          	auipc	ra,0x0
    354a:	6be080e7          	jalr	1726(ra) # 3c04 <strchr>
    354e:	c501                	beqz	a0,3556 <peek+0x3c>
    s++;
    3550:	0485                	addi	s1,s1,1
  while(s < es && strchr(whitespace, *s))
    3552:	fe9917e3          	bne	s2,s1,3540 <peek+0x26>
  *ps = s;
    3556:	009a3023          	sd	s1,0(s4)
  return *s && strchr(toks, *s);
    355a:	0004c583          	lbu	a1,0(s1)
    355e:	4501                	li	a0,0
    3560:	e991                	bnez	a1,3574 <peek+0x5a>
}
    3562:	70e2                	ld	ra,56(sp)
    3564:	7442                	ld	s0,48(sp)
    3566:	74a2                	ld	s1,40(sp)
    3568:	7902                	ld	s2,32(sp)
    356a:	69e2                	ld	s3,24(sp)
    356c:	6a42                	ld	s4,16(sp)
    356e:	6aa2                	ld	s5,8(sp)
    3570:	6121                	addi	sp,sp,64
    3572:	8082                	ret
  return *s && strchr(toks, *s);
    3574:	8556                	mv	a0,s5
    3576:	00000097          	auipc	ra,0x0
    357a:	68e080e7          	jalr	1678(ra) # 3c04 <strchr>
    357e:	00a03533          	snez	a0,a0
    3582:	b7c5                	j	3562 <peek+0x48>

0000000000003584 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
    3584:	7159                	addi	sp,sp,-112
    3586:	f486                	sd	ra,104(sp)
    3588:	f0a2                	sd	s0,96(sp)
    358a:	eca6                	sd	s1,88(sp)
    358c:	e8ca                	sd	s2,80(sp)
    358e:	e4ce                	sd	s3,72(sp)
    3590:	e0d2                	sd	s4,64(sp)
    3592:	fc56                	sd	s5,56(sp)
    3594:	f85a                	sd	s6,48(sp)
    3596:	f45e                	sd	s7,40(sp)
    3598:	f062                	sd	s8,32(sp)
    359a:	ec66                	sd	s9,24(sp)
    359c:	1880                	addi	s0,sp,112
    359e:	8a2a                	mv	s4,a0
    35a0:	89ae                	mv	s3,a1
    35a2:	8932                	mv	s2,a2
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
    35a4:	00001b97          	auipc	s7,0x1
    35a8:	e44b8b93          	addi	s7,s7,-444 # 43e8 <malloc+0x14c>
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
    35ac:	06100c13          	li	s8,97
      panic("missing file for redirection");
    switch(tok){
    35b0:	03c00c93          	li	s9,60
  while(peek(ps, es, "<>")){
    35b4:	a02d                	j	35de <parseredirs+0x5a>
      panic("missing file for redirection");
    35b6:	00001517          	auipc	a0,0x1
    35ba:	e1250513          	addi	a0,a0,-494 # 43c8 <malloc+0x12c>
    35be:	00000097          	auipc	ra,0x0
    35c2:	a98080e7          	jalr	-1384(ra) # 3056 <panic>
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
    35c6:	4701                	li	a4,0
    35c8:	4681                	li	a3,0
    35ca:	f9043603          	ld	a2,-112(s0)
    35ce:	f9843583          	ld	a1,-104(s0)
    35d2:	8552                	mv	a0,s4
    35d4:	00000097          	auipc	ra,0x0
    35d8:	cda080e7          	jalr	-806(ra) # 32ae <redircmd>
    35dc:	8a2a                	mv	s4,a0
    switch(tok){
    35de:	03e00b13          	li	s6,62
    35e2:	02b00a93          	li	s5,43
  while(peek(ps, es, "<>")){
    35e6:	865e                	mv	a2,s7
    35e8:	85ca                	mv	a1,s2
    35ea:	854e                	mv	a0,s3
    35ec:	00000097          	auipc	ra,0x0
    35f0:	f2e080e7          	jalr	-210(ra) # 351a <peek>
    35f4:	c925                	beqz	a0,3664 <parseredirs+0xe0>
    tok = gettoken(ps, es, 0, 0);
    35f6:	4681                	li	a3,0
    35f8:	4601                	li	a2,0
    35fa:	85ca                	mv	a1,s2
    35fc:	854e                	mv	a0,s3
    35fe:	00000097          	auipc	ra,0x0
    3602:	de0080e7          	jalr	-544(ra) # 33de <gettoken>
    3606:	84aa                	mv	s1,a0
    if(gettoken(ps, es, &q, &eq) != 'a')
    3608:	f9040693          	addi	a3,s0,-112
    360c:	f9840613          	addi	a2,s0,-104
    3610:	85ca                	mv	a1,s2
    3612:	854e                	mv	a0,s3
    3614:	00000097          	auipc	ra,0x0
    3618:	dca080e7          	jalr	-566(ra) # 33de <gettoken>
    361c:	f9851de3          	bne	a0,s8,35b6 <parseredirs+0x32>
    switch(tok){
    3620:	fb9483e3          	beq	s1,s9,35c6 <parseredirs+0x42>
    3624:	03648263          	beq	s1,s6,3648 <parseredirs+0xc4>
    3628:	fb549fe3          	bne	s1,s5,35e6 <parseredirs+0x62>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
    362c:	4705                	li	a4,1
    362e:	20100693          	li	a3,513
    3632:	f9043603          	ld	a2,-112(s0)
    3636:	f9843583          	ld	a1,-104(s0)
    363a:	8552                	mv	a0,s4
    363c:	00000097          	auipc	ra,0x0
    3640:	c72080e7          	jalr	-910(ra) # 32ae <redircmd>
    3644:	8a2a                	mv	s4,a0
      break;
    3646:	bf61                	j	35de <parseredirs+0x5a>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE|O_TRUNC, 1);
    3648:	4705                	li	a4,1
    364a:	60100693          	li	a3,1537
    364e:	f9043603          	ld	a2,-112(s0)
    3652:	f9843583          	ld	a1,-104(s0)
    3656:	8552                	mv	a0,s4
    3658:	00000097          	auipc	ra,0x0
    365c:	c56080e7          	jalr	-938(ra) # 32ae <redircmd>
    3660:	8a2a                	mv	s4,a0
      break;
    3662:	bfb5                	j	35de <parseredirs+0x5a>
    }
  }
  return cmd;
}
    3664:	8552                	mv	a0,s4
    3666:	70a6                	ld	ra,104(sp)
    3668:	7406                	ld	s0,96(sp)
    366a:	64e6                	ld	s1,88(sp)
    366c:	6946                	ld	s2,80(sp)
    366e:	69a6                	ld	s3,72(sp)
    3670:	6a06                	ld	s4,64(sp)
    3672:	7ae2                	ld	s5,56(sp)
    3674:	7b42                	ld	s6,48(sp)
    3676:	7ba2                	ld	s7,40(sp)
    3678:	7c02                	ld	s8,32(sp)
    367a:	6ce2                	ld	s9,24(sp)
    367c:	6165                	addi	sp,sp,112
    367e:	8082                	ret

0000000000003680 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
    3680:	7159                	addi	sp,sp,-112
    3682:	f486                	sd	ra,104(sp)
    3684:	f0a2                	sd	s0,96(sp)
    3686:	eca6                	sd	s1,88(sp)
    3688:	e8ca                	sd	s2,80(sp)
    368a:	e4ce                	sd	s3,72(sp)
    368c:	e0d2                	sd	s4,64(sp)
    368e:	fc56                	sd	s5,56(sp)
    3690:	f85a                	sd	s6,48(sp)
    3692:	f45e                	sd	s7,40(sp)
    3694:	f062                	sd	s8,32(sp)
    3696:	ec66                	sd	s9,24(sp)
    3698:	1880                	addi	s0,sp,112
    369a:	8a2a                	mv	s4,a0
    369c:	8aae                	mv	s5,a1
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    369e:	00001617          	auipc	a2,0x1
    36a2:	d5260613          	addi	a2,a2,-686 # 43f0 <malloc+0x154>
    36a6:	00000097          	auipc	ra,0x0
    36aa:	e74080e7          	jalr	-396(ra) # 351a <peek>
    36ae:	e905                	bnez	a0,36de <parseexec+0x5e>
    36b0:	89aa                	mv	s3,a0
    return parseblock(ps, es);

  ret = execcmd();
    36b2:	00000097          	auipc	ra,0x0
    36b6:	bc6080e7          	jalr	-1082(ra) # 3278 <execcmd>
    36ba:	8c2a                	mv	s8,a0
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
    36bc:	8656                	mv	a2,s5
    36be:	85d2                	mv	a1,s4
    36c0:	00000097          	auipc	ra,0x0
    36c4:	ec4080e7          	jalr	-316(ra) # 3584 <parseredirs>
    36c8:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
    36ca:	008c0913          	addi	s2,s8,8
    36ce:	00001b17          	auipc	s6,0x1
    36d2:	d42b0b13          	addi	s6,s6,-702 # 4410 <malloc+0x174>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
    36d6:	06100c93          	li	s9,97
      panic("syntax");
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
    36da:	4bd1                	li	s7,20
  while(!peek(ps, es, "|)&;")){
    36dc:	a80d                	j	370e <parseexec+0x8e>
    return parseblock(ps, es);
    36de:	85d6                	mv	a1,s5
    36e0:	8552                	mv	a0,s4
    36e2:	00000097          	auipc	ra,0x0
    36e6:	1bc080e7          	jalr	444(ra) # 389e <parseblock>
    36ea:	84aa                	mv	s1,a0
    36ec:	a041                	j	376c <parseexec+0xec>
      panic("syntax");
    36ee:	00001517          	auipc	a0,0x1
    36f2:	d0a50513          	addi	a0,a0,-758 # 43f8 <malloc+0x15c>
    36f6:	00000097          	auipc	ra,0x0
    36fa:	960080e7          	jalr	-1696(ra) # 3056 <panic>
      panic("too many args");
    ret = parseredirs(ret, ps, es);
    36fe:	8656                	mv	a2,s5
    3700:	85d2                	mv	a1,s4
    3702:	8526                	mv	a0,s1
    3704:	00000097          	auipc	ra,0x0
    3708:	e80080e7          	jalr	-384(ra) # 3584 <parseredirs>
    370c:	84aa                	mv	s1,a0
  while(!peek(ps, es, "|)&;")){
    370e:	865a                	mv	a2,s6
    3710:	85d6                	mv	a1,s5
    3712:	8552                	mv	a0,s4
    3714:	00000097          	auipc	ra,0x0
    3718:	e06080e7          	jalr	-506(ra) # 351a <peek>
    371c:	e131                	bnez	a0,3760 <parseexec+0xe0>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
    371e:	f9040693          	addi	a3,s0,-112
    3722:	f9840613          	addi	a2,s0,-104
    3726:	85d6                	mv	a1,s5
    3728:	8552                	mv	a0,s4
    372a:	00000097          	auipc	ra,0x0
    372e:	cb4080e7          	jalr	-844(ra) # 33de <gettoken>
    3732:	c51d                	beqz	a0,3760 <parseexec+0xe0>
    if(tok != 'a')
    3734:	fb951de3          	bne	a0,s9,36ee <parseexec+0x6e>
    cmd->argv[argc] = q;
    3738:	f9843783          	ld	a5,-104(s0)
    373c:	00f93023          	sd	a5,0(s2)
    cmd->eargv[argc] = eq;
    3740:	f9043783          	ld	a5,-112(s0)
    3744:	0af93023          	sd	a5,160(s2)
    argc++;
    3748:	2985                	addiw	s3,s3,1
    if(argc >= MAXARGS)
    374a:	0921                	addi	s2,s2,8
    374c:	fb7999e3          	bne	s3,s7,36fe <parseexec+0x7e>
      panic("too many args");
    3750:	00001517          	auipc	a0,0x1
    3754:	cb050513          	addi	a0,a0,-848 # 4400 <malloc+0x164>
    3758:	00000097          	auipc	ra,0x0
    375c:	8fe080e7          	jalr	-1794(ra) # 3056 <panic>
  }
  cmd->argv[argc] = 0;
    3760:	098e                	slli	s3,s3,0x3
    3762:	99e2                	add	s3,s3,s8
    3764:	0009b423          	sd	zero,8(s3)
  cmd->eargv[argc] = 0;
    3768:	0a09b423          	sd	zero,168(s3)
  return ret;
}
    376c:	8526                	mv	a0,s1
    376e:	70a6                	ld	ra,104(sp)
    3770:	7406                	ld	s0,96(sp)
    3772:	64e6                	ld	s1,88(sp)
    3774:	6946                	ld	s2,80(sp)
    3776:	69a6                	ld	s3,72(sp)
    3778:	6a06                	ld	s4,64(sp)
    377a:	7ae2                	ld	s5,56(sp)
    377c:	7b42                	ld	s6,48(sp)
    377e:	7ba2                	ld	s7,40(sp)
    3780:	7c02                	ld	s8,32(sp)
    3782:	6ce2                	ld	s9,24(sp)
    3784:	6165                	addi	sp,sp,112
    3786:	8082                	ret

0000000000003788 <parsepipe>:
{
    3788:	7179                	addi	sp,sp,-48
    378a:	f406                	sd	ra,40(sp)
    378c:	f022                	sd	s0,32(sp)
    378e:	ec26                	sd	s1,24(sp)
    3790:	e84a                	sd	s2,16(sp)
    3792:	e44e                	sd	s3,8(sp)
    3794:	1800                	addi	s0,sp,48
    3796:	892a                	mv	s2,a0
    3798:	89ae                	mv	s3,a1
  cmd = parseexec(ps, es);
    379a:	00000097          	auipc	ra,0x0
    379e:	ee6080e7          	jalr	-282(ra) # 3680 <parseexec>
    37a2:	84aa                	mv	s1,a0
  if(peek(ps, es, "|")){
    37a4:	00001617          	auipc	a2,0x1
    37a8:	c7460613          	addi	a2,a2,-908 # 4418 <malloc+0x17c>
    37ac:	85ce                	mv	a1,s3
    37ae:	854a                	mv	a0,s2
    37b0:	00000097          	auipc	ra,0x0
    37b4:	d6a080e7          	jalr	-662(ra) # 351a <peek>
    37b8:	e909                	bnez	a0,37ca <parsepipe+0x42>
}
    37ba:	8526                	mv	a0,s1
    37bc:	70a2                	ld	ra,40(sp)
    37be:	7402                	ld	s0,32(sp)
    37c0:	64e2                	ld	s1,24(sp)
    37c2:	6942                	ld	s2,16(sp)
    37c4:	69a2                	ld	s3,8(sp)
    37c6:	6145                	addi	sp,sp,48
    37c8:	8082                	ret
    gettoken(ps, es, 0, 0);
    37ca:	4681                	li	a3,0
    37cc:	4601                	li	a2,0
    37ce:	85ce                	mv	a1,s3
    37d0:	854a                	mv	a0,s2
    37d2:	00000097          	auipc	ra,0x0
    37d6:	c0c080e7          	jalr	-1012(ra) # 33de <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
    37da:	85ce                	mv	a1,s3
    37dc:	854a                	mv	a0,s2
    37de:	00000097          	auipc	ra,0x0
    37e2:	faa080e7          	jalr	-86(ra) # 3788 <parsepipe>
    37e6:	85aa                	mv	a1,a0
    37e8:	8526                	mv	a0,s1
    37ea:	00000097          	auipc	ra,0x0
    37ee:	b2c080e7          	jalr	-1236(ra) # 3316 <pipecmd>
    37f2:	84aa                	mv	s1,a0
  return cmd;
    37f4:	b7d9                	j	37ba <parsepipe+0x32>

00000000000037f6 <parseline>:
{
    37f6:	7179                	addi	sp,sp,-48
    37f8:	f406                	sd	ra,40(sp)
    37fa:	f022                	sd	s0,32(sp)
    37fc:	ec26                	sd	s1,24(sp)
    37fe:	e84a                	sd	s2,16(sp)
    3800:	e44e                	sd	s3,8(sp)
    3802:	e052                	sd	s4,0(sp)
    3804:	1800                	addi	s0,sp,48
    3806:	892a                	mv	s2,a0
    3808:	89ae                	mv	s3,a1
  cmd = parsepipe(ps, es);
    380a:	00000097          	auipc	ra,0x0
    380e:	f7e080e7          	jalr	-130(ra) # 3788 <parsepipe>
    3812:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
    3814:	00001a17          	auipc	s4,0x1
    3818:	c0ca0a13          	addi	s4,s4,-1012 # 4420 <malloc+0x184>
    381c:	a839                	j	383a <parseline+0x44>
    gettoken(ps, es, 0, 0);
    381e:	4681                	li	a3,0
    3820:	4601                	li	a2,0
    3822:	85ce                	mv	a1,s3
    3824:	854a                	mv	a0,s2
    3826:	00000097          	auipc	ra,0x0
    382a:	bb8080e7          	jalr	-1096(ra) # 33de <gettoken>
    cmd = backcmd(cmd);
    382e:	8526                	mv	a0,s1
    3830:	00000097          	auipc	ra,0x0
    3834:	b72080e7          	jalr	-1166(ra) # 33a2 <backcmd>
    3838:	84aa                	mv	s1,a0
  while(peek(ps, es, "&")){
    383a:	8652                	mv	a2,s4
    383c:	85ce                	mv	a1,s3
    383e:	854a                	mv	a0,s2
    3840:	00000097          	auipc	ra,0x0
    3844:	cda080e7          	jalr	-806(ra) # 351a <peek>
    3848:	f979                	bnez	a0,381e <parseline+0x28>
  if(peek(ps, es, ";")){
    384a:	00001617          	auipc	a2,0x1
    384e:	bde60613          	addi	a2,a2,-1058 # 4428 <malloc+0x18c>
    3852:	85ce                	mv	a1,s3
    3854:	854a                	mv	a0,s2
    3856:	00000097          	auipc	ra,0x0
    385a:	cc4080e7          	jalr	-828(ra) # 351a <peek>
    385e:	e911                	bnez	a0,3872 <parseline+0x7c>
}
    3860:	8526                	mv	a0,s1
    3862:	70a2                	ld	ra,40(sp)
    3864:	7402                	ld	s0,32(sp)
    3866:	64e2                	ld	s1,24(sp)
    3868:	6942                	ld	s2,16(sp)
    386a:	69a2                	ld	s3,8(sp)
    386c:	6a02                	ld	s4,0(sp)
    386e:	6145                	addi	sp,sp,48
    3870:	8082                	ret
    gettoken(ps, es, 0, 0);
    3872:	4681                	li	a3,0
    3874:	4601                	li	a2,0
    3876:	85ce                	mv	a1,s3
    3878:	854a                	mv	a0,s2
    387a:	00000097          	auipc	ra,0x0
    387e:	b64080e7          	jalr	-1180(ra) # 33de <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
    3882:	85ce                	mv	a1,s3
    3884:	854a                	mv	a0,s2
    3886:	00000097          	auipc	ra,0x0
    388a:	f70080e7          	jalr	-144(ra) # 37f6 <parseline>
    388e:	85aa                	mv	a1,a0
    3890:	8526                	mv	a0,s1
    3892:	00000097          	auipc	ra,0x0
    3896:	aca080e7          	jalr	-1334(ra) # 335c <listcmd>
    389a:	84aa                	mv	s1,a0
  return cmd;
    389c:	b7d1                	j	3860 <parseline+0x6a>

000000000000389e <parseblock>:
{
    389e:	7179                	addi	sp,sp,-48
    38a0:	f406                	sd	ra,40(sp)
    38a2:	f022                	sd	s0,32(sp)
    38a4:	ec26                	sd	s1,24(sp)
    38a6:	e84a                	sd	s2,16(sp)
    38a8:	e44e                	sd	s3,8(sp)
    38aa:	1800                	addi	s0,sp,48
    38ac:	84aa                	mv	s1,a0
    38ae:	892e                	mv	s2,a1
  if(!peek(ps, es, "("))
    38b0:	00001617          	auipc	a2,0x1
    38b4:	b4060613          	addi	a2,a2,-1216 # 43f0 <malloc+0x154>
    38b8:	00000097          	auipc	ra,0x0
    38bc:	c62080e7          	jalr	-926(ra) # 351a <peek>
    38c0:	c12d                	beqz	a0,3922 <parseblock+0x84>
  gettoken(ps, es, 0, 0);
    38c2:	4681                	li	a3,0
    38c4:	4601                	li	a2,0
    38c6:	85ca                	mv	a1,s2
    38c8:	8526                	mv	a0,s1
    38ca:	00000097          	auipc	ra,0x0
    38ce:	b14080e7          	jalr	-1260(ra) # 33de <gettoken>
  cmd = parseline(ps, es);
    38d2:	85ca                	mv	a1,s2
    38d4:	8526                	mv	a0,s1
    38d6:	00000097          	auipc	ra,0x0
    38da:	f20080e7          	jalr	-224(ra) # 37f6 <parseline>
    38de:	89aa                	mv	s3,a0
  if(!peek(ps, es, ")"))
    38e0:	00001617          	auipc	a2,0x1
    38e4:	b6060613          	addi	a2,a2,-1184 # 4440 <malloc+0x1a4>
    38e8:	85ca                	mv	a1,s2
    38ea:	8526                	mv	a0,s1
    38ec:	00000097          	auipc	ra,0x0
    38f0:	c2e080e7          	jalr	-978(ra) # 351a <peek>
    38f4:	cd1d                	beqz	a0,3932 <parseblock+0x94>
  gettoken(ps, es, 0, 0);
    38f6:	4681                	li	a3,0
    38f8:	4601                	li	a2,0
    38fa:	85ca                	mv	a1,s2
    38fc:	8526                	mv	a0,s1
    38fe:	00000097          	auipc	ra,0x0
    3902:	ae0080e7          	jalr	-1312(ra) # 33de <gettoken>
  cmd = parseredirs(cmd, ps, es);
    3906:	864a                	mv	a2,s2
    3908:	85a6                	mv	a1,s1
    390a:	854e                	mv	a0,s3
    390c:	00000097          	auipc	ra,0x0
    3910:	c78080e7          	jalr	-904(ra) # 3584 <parseredirs>
}
    3914:	70a2                	ld	ra,40(sp)
    3916:	7402                	ld	s0,32(sp)
    3918:	64e2                	ld	s1,24(sp)
    391a:	6942                	ld	s2,16(sp)
    391c:	69a2                	ld	s3,8(sp)
    391e:	6145                	addi	sp,sp,48
    3920:	8082                	ret
    panic("parseblock");
    3922:	00001517          	auipc	a0,0x1
    3926:	b0e50513          	addi	a0,a0,-1266 # 4430 <malloc+0x194>
    392a:	fffff097          	auipc	ra,0xfffff
    392e:	72c080e7          	jalr	1836(ra) # 3056 <panic>
    panic("syntax - missing )");
    3932:	00001517          	auipc	a0,0x1
    3936:	b1650513          	addi	a0,a0,-1258 # 4448 <malloc+0x1ac>
    393a:	fffff097          	auipc	ra,0xfffff
    393e:	71c080e7          	jalr	1820(ra) # 3056 <panic>

0000000000003942 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
    3942:	1101                	addi	sp,sp,-32
    3944:	ec06                	sd	ra,24(sp)
    3946:	e822                	sd	s0,16(sp)
    3948:	e426                	sd	s1,8(sp)
    394a:	1000                	addi	s0,sp,32
    394c:	84aa                	mv	s1,a0
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    394e:	c521                	beqz	a0,3996 <nulterminate+0x54>
    return 0;

  switch(cmd->type){
    3950:	4118                	lw	a4,0(a0)
    3952:	4795                	li	a5,5
    3954:	04e7e163          	bltu	a5,a4,3996 <nulterminate+0x54>
    3958:	00056783          	lwu	a5,0(a0)
    395c:	078a                	slli	a5,a5,0x2
    395e:	00001717          	auipc	a4,0x1
    3962:	b4a70713          	addi	a4,a4,-1206 # 44a8 <malloc+0x20c>
    3966:	97ba                	add	a5,a5,a4
    3968:	439c                	lw	a5,0(a5)
    396a:	97ba                	add	a5,a5,a4
    396c:	8782                	jr	a5
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
    396e:	651c                	ld	a5,8(a0)
    3970:	c39d                	beqz	a5,3996 <nulterminate+0x54>
    3972:	01050793          	addi	a5,a0,16
      *ecmd->eargv[i] = 0;
    3976:	6fd8                	ld	a4,152(a5)
    3978:	00070023          	sb	zero,0(a4)
    for(i=0; ecmd->argv[i]; i++)
    397c:	07a1                	addi	a5,a5,8
    397e:	ff87b703          	ld	a4,-8(a5)
    3982:	fb75                	bnez	a4,3976 <nulterminate+0x34>
    3984:	a809                	j	3996 <nulterminate+0x54>
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
    3986:	6508                	ld	a0,8(a0)
    3988:	00000097          	auipc	ra,0x0
    398c:	fba080e7          	jalr	-70(ra) # 3942 <nulterminate>
    *rcmd->efile = 0;
    3990:	6c9c                	ld	a5,24(s1)
    3992:	00078023          	sb	zero,0(a5)
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
    3996:	8526                	mv	a0,s1
    3998:	60e2                	ld	ra,24(sp)
    399a:	6442                	ld	s0,16(sp)
    399c:	64a2                	ld	s1,8(sp)
    399e:	6105                	addi	sp,sp,32
    39a0:	8082                	ret
    nulterminate(pcmd->left);
    39a2:	6508                	ld	a0,8(a0)
    39a4:	00000097          	auipc	ra,0x0
    39a8:	f9e080e7          	jalr	-98(ra) # 3942 <nulterminate>
    nulterminate(pcmd->right);
    39ac:	6888                	ld	a0,16(s1)
    39ae:	00000097          	auipc	ra,0x0
    39b2:	f94080e7          	jalr	-108(ra) # 3942 <nulterminate>
    break;
    39b6:	b7c5                	j	3996 <nulterminate+0x54>
    nulterminate(lcmd->left);
    39b8:	6508                	ld	a0,8(a0)
    39ba:	00000097          	auipc	ra,0x0
    39be:	f88080e7          	jalr	-120(ra) # 3942 <nulterminate>
    nulterminate(lcmd->right);
    39c2:	6888                	ld	a0,16(s1)
    39c4:	00000097          	auipc	ra,0x0
    39c8:	f7e080e7          	jalr	-130(ra) # 3942 <nulterminate>
    break;
    39cc:	b7e9                	j	3996 <nulterminate+0x54>
    nulterminate(bcmd->cmd);
    39ce:	6508                	ld	a0,8(a0)
    39d0:	00000097          	auipc	ra,0x0
    39d4:	f72080e7          	jalr	-142(ra) # 3942 <nulterminate>
    break;
    39d8:	bf7d                	j	3996 <nulterminate+0x54>

00000000000039da <parsecmd>:
{
    39da:	7179                	addi	sp,sp,-48
    39dc:	f406                	sd	ra,40(sp)
    39de:	f022                	sd	s0,32(sp)
    39e0:	ec26                	sd	s1,24(sp)
    39e2:	e84a                	sd	s2,16(sp)
    39e4:	1800                	addi	s0,sp,48
    39e6:	fca43c23          	sd	a0,-40(s0)
  es = s + strlen(s);
    39ea:	84aa                	mv	s1,a0
    39ec:	00000097          	auipc	ra,0x0
    39f0:	1cc080e7          	jalr	460(ra) # 3bb8 <strlen>
    39f4:	1502                	slli	a0,a0,0x20
    39f6:	9101                	srli	a0,a0,0x20
    39f8:	94aa                	add	s1,s1,a0
  cmd = parseline(&s, es);
    39fa:	85a6                	mv	a1,s1
    39fc:	fd840513          	addi	a0,s0,-40
    3a00:	00000097          	auipc	ra,0x0
    3a04:	df6080e7          	jalr	-522(ra) # 37f6 <parseline>
    3a08:	892a                	mv	s2,a0
  peek(&s, es, "");
    3a0a:	00001617          	auipc	a2,0x1
    3a0e:	a5660613          	addi	a2,a2,-1450 # 4460 <malloc+0x1c4>
    3a12:	85a6                	mv	a1,s1
    3a14:	fd840513          	addi	a0,s0,-40
    3a18:	00000097          	auipc	ra,0x0
    3a1c:	b02080e7          	jalr	-1278(ra) # 351a <peek>
  if(s != es){
    3a20:	fd843603          	ld	a2,-40(s0)
    3a24:	00961e63          	bne	a2,s1,3a40 <parsecmd+0x66>
  nulterminate(cmd);
    3a28:	854a                	mv	a0,s2
    3a2a:	00000097          	auipc	ra,0x0
    3a2e:	f18080e7          	jalr	-232(ra) # 3942 <nulterminate>
}
    3a32:	854a                	mv	a0,s2
    3a34:	70a2                	ld	ra,40(sp)
    3a36:	7402                	ld	s0,32(sp)
    3a38:	64e2                	ld	s1,24(sp)
    3a3a:	6942                	ld	s2,16(sp)
    3a3c:	6145                	addi	sp,sp,48
    3a3e:	8082                	ret
    fprintf(2, "leftovers: %s\n", s);
    3a40:	00001597          	auipc	a1,0x1
    3a44:	a2858593          	addi	a1,a1,-1496 # 4468 <malloc+0x1cc>
    3a48:	4509                	li	a0,2
    3a4a:	00000097          	auipc	ra,0x0
    3a4e:	766080e7          	jalr	1894(ra) # 41b0 <fprintf>
    panic("syntax");
    3a52:	00001517          	auipc	a0,0x1
    3a56:	9a650513          	addi	a0,a0,-1626 # 43f8 <malloc+0x15c>
    3a5a:	fffff097          	auipc	ra,0xfffff
    3a5e:	5fc080e7          	jalr	1532(ra) # 3056 <panic>

0000000000003a62 <main>:
{
    3a62:	7139                	addi	sp,sp,-64
    3a64:	fc06                	sd	ra,56(sp)
    3a66:	f822                	sd	s0,48(sp)
    3a68:	f426                	sd	s1,40(sp)
    3a6a:	f04a                	sd	s2,32(sp)
    3a6c:	ec4e                	sd	s3,24(sp)
    3a6e:	e852                	sd	s4,16(sp)
    3a70:	e456                	sd	s5,8(sp)
    3a72:	0080                	addi	s0,sp,64
  while((fd = open("console", O_RDWR)) >= 0){
    3a74:	00001497          	auipc	s1,0x1
    3a78:	a0448493          	addi	s1,s1,-1532 # 4478 <malloc+0x1dc>
    3a7c:	4589                	li	a1,2
    3a7e:	8526                	mv	a0,s1
    3a80:	00000097          	auipc	ra,0x0
    3a84:	3fe080e7          	jalr	1022(ra) # 3e7e <open>
    3a88:	00054963          	bltz	a0,3a9a <main+0x38>
    if(fd >= 3){
    3a8c:	4789                	li	a5,2
    3a8e:	fea7d7e3          	bge	a5,a0,3a7c <main+0x1a>
      close(fd);
    3a92:	00000097          	auipc	ra,0x0
    3a96:	3d4080e7          	jalr	980(ra) # 3e66 <close>
  while(getcmd(buf, sizeof(buf)) >= 0){
    3a9a:	00001497          	auipc	s1,0x1
    3a9e:	58648493          	addi	s1,s1,1414 # 5020 <buf.0>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
    3aa2:	06300913          	li	s2,99
    3aa6:	02000993          	li	s3,32
      if(chdir(buf+3) < 0)
    3aaa:	00001a17          	auipc	s4,0x1
    3aae:	579a0a13          	addi	s4,s4,1401 # 5023 <buf.0+0x3>
        fprintf(2, "cannot cd %s\n", buf+3);
    3ab2:	00001a97          	auipc	s5,0x1
    3ab6:	9cea8a93          	addi	s5,s5,-1586 # 4480 <malloc+0x1e4>
    3aba:	a819                	j	3ad0 <main+0x6e>
    if(fork1() == 0)
    3abc:	fffff097          	auipc	ra,0xfffff
    3ac0:	5c0080e7          	jalr	1472(ra) # 307c <fork1>
    3ac4:	c925                	beqz	a0,3b34 <main+0xd2>
    wait(0);
    3ac6:	4501                	li	a0,0
    3ac8:	00000097          	auipc	ra,0x0
    3acc:	376080e7          	jalr	886(ra) # 3e3e <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
    3ad0:	06400593          	li	a1,100
    3ad4:	8526                	mv	a0,s1
    3ad6:	fffff097          	auipc	ra,0xfffff
    3ada:	52a080e7          	jalr	1322(ra) # 3000 <getcmd>
    3ade:	06054763          	bltz	a0,3b4c <main+0xea>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
    3ae2:	0004c783          	lbu	a5,0(s1)
    3ae6:	fd279be3          	bne	a5,s2,3abc <main+0x5a>
    3aea:	0014c703          	lbu	a4,1(s1)
    3aee:	06400793          	li	a5,100
    3af2:	fcf715e3          	bne	a4,a5,3abc <main+0x5a>
    3af6:	0024c783          	lbu	a5,2(s1)
    3afa:	fd3791e3          	bne	a5,s3,3abc <main+0x5a>
      buf[strlen(buf)-1] = 0;  // chop \n
    3afe:	8526                	mv	a0,s1
    3b00:	00000097          	auipc	ra,0x0
    3b04:	0b8080e7          	jalr	184(ra) # 3bb8 <strlen>
    3b08:	fff5079b          	addiw	a5,a0,-1
    3b0c:	1782                	slli	a5,a5,0x20
    3b0e:	9381                	srli	a5,a5,0x20
    3b10:	97a6                	add	a5,a5,s1
    3b12:	00078023          	sb	zero,0(a5)
      if(chdir(buf+3) < 0)
    3b16:	8552                	mv	a0,s4
    3b18:	00000097          	auipc	ra,0x0
    3b1c:	396080e7          	jalr	918(ra) # 3eae <chdir>
    3b20:	fa0558e3          	bgez	a0,3ad0 <main+0x6e>
        fprintf(2, "cannot cd %s\n", buf+3);
    3b24:	8652                	mv	a2,s4
    3b26:	85d6                	mv	a1,s5
    3b28:	4509                	li	a0,2
    3b2a:	00000097          	auipc	ra,0x0
    3b2e:	686080e7          	jalr	1670(ra) # 41b0 <fprintf>
    3b32:	bf79                	j	3ad0 <main+0x6e>
      runcmd(parsecmd(buf));
    3b34:	00001517          	auipc	a0,0x1
    3b38:	4ec50513          	addi	a0,a0,1260 # 5020 <buf.0>
    3b3c:	00000097          	auipc	ra,0x0
    3b40:	e9e080e7          	jalr	-354(ra) # 39da <parsecmd>
    3b44:	fffff097          	auipc	ra,0xfffff
    3b48:	566080e7          	jalr	1382(ra) # 30aa <runcmd>
  exit(0);
    3b4c:	4501                	li	a0,0
    3b4e:	00000097          	auipc	ra,0x0
    3b52:	2e8080e7          	jalr	744(ra) # 3e36 <exit>

0000000000003b56 <_main>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
_main()
{
    3b56:	1141                	addi	sp,sp,-16
    3b58:	e406                	sd	ra,8(sp)
    3b5a:	e022                	sd	s0,0(sp)
    3b5c:	0800                	addi	s0,sp,16
  extern int main();
  main();
    3b5e:	00000097          	auipc	ra,0x0
    3b62:	f04080e7          	jalr	-252(ra) # 3a62 <main>
  exit(0);
    3b66:	4501                	li	a0,0
    3b68:	00000097          	auipc	ra,0x0
    3b6c:	2ce080e7          	jalr	718(ra) # 3e36 <exit>

0000000000003b70 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
    3b70:	1141                	addi	sp,sp,-16
    3b72:	e422                	sd	s0,8(sp)
    3b74:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3b76:	87aa                	mv	a5,a0
    3b78:	0585                	addi	a1,a1,1
    3b7a:	0785                	addi	a5,a5,1
    3b7c:	fff5c703          	lbu	a4,-1(a1)
    3b80:	fee78fa3          	sb	a4,-1(a5)
    3b84:	fb75                	bnez	a4,3b78 <strcpy+0x8>
    ;
  return os;
}
    3b86:	6422                	ld	s0,8(sp)
    3b88:	0141                	addi	sp,sp,16
    3b8a:	8082                	ret

0000000000003b8c <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3b8c:	1141                	addi	sp,sp,-16
    3b8e:	e422                	sd	s0,8(sp)
    3b90:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    3b92:	00054783          	lbu	a5,0(a0)
    3b96:	cb91                	beqz	a5,3baa <strcmp+0x1e>
    3b98:	0005c703          	lbu	a4,0(a1)
    3b9c:	00f71763          	bne	a4,a5,3baa <strcmp+0x1e>
    p++, q++;
    3ba0:	0505                	addi	a0,a0,1
    3ba2:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    3ba4:	00054783          	lbu	a5,0(a0)
    3ba8:	fbe5                	bnez	a5,3b98 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    3baa:	0005c503          	lbu	a0,0(a1)
}
    3bae:	40a7853b          	subw	a0,a5,a0
    3bb2:	6422                	ld	s0,8(sp)
    3bb4:	0141                	addi	sp,sp,16
    3bb6:	8082                	ret

0000000000003bb8 <strlen>:

uint
strlen(const char *s)
{
    3bb8:	1141                	addi	sp,sp,-16
    3bba:	e422                	sd	s0,8(sp)
    3bbc:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    3bbe:	00054783          	lbu	a5,0(a0)
    3bc2:	cf91                	beqz	a5,3bde <strlen+0x26>
    3bc4:	0505                	addi	a0,a0,1
    3bc6:	87aa                	mv	a5,a0
    3bc8:	4685                	li	a3,1
    3bca:	9e89                	subw	a3,a3,a0
    3bcc:	00f6853b          	addw	a0,a3,a5
    3bd0:	0785                	addi	a5,a5,1
    3bd2:	fff7c703          	lbu	a4,-1(a5)
    3bd6:	fb7d                	bnez	a4,3bcc <strlen+0x14>
    ;
  return n;
}
    3bd8:	6422                	ld	s0,8(sp)
    3bda:	0141                	addi	sp,sp,16
    3bdc:	8082                	ret
  for(n = 0; s[n]; n++)
    3bde:	4501                	li	a0,0
    3be0:	bfe5                	j	3bd8 <strlen+0x20>

0000000000003be2 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3be2:	1141                	addi	sp,sp,-16
    3be4:	e422                	sd	s0,8(sp)
    3be6:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    3be8:	ca19                	beqz	a2,3bfe <memset+0x1c>
    3bea:	87aa                	mv	a5,a0
    3bec:	1602                	slli	a2,a2,0x20
    3bee:	9201                	srli	a2,a2,0x20
    3bf0:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    3bf4:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    3bf8:	0785                	addi	a5,a5,1
    3bfa:	fee79de3          	bne	a5,a4,3bf4 <memset+0x12>
  }
  return dst;
}
    3bfe:	6422                	ld	s0,8(sp)
    3c00:	0141                	addi	sp,sp,16
    3c02:	8082                	ret

0000000000003c04 <strchr>:

char*
strchr(const char *s, char c)
{
    3c04:	1141                	addi	sp,sp,-16
    3c06:	e422                	sd	s0,8(sp)
    3c08:	0800                	addi	s0,sp,16
  for(; *s; s++)
    3c0a:	00054783          	lbu	a5,0(a0)
    3c0e:	cb99                	beqz	a5,3c24 <strchr+0x20>
    if(*s == c)
    3c10:	00f58763          	beq	a1,a5,3c1e <strchr+0x1a>
  for(; *s; s++)
    3c14:	0505                	addi	a0,a0,1
    3c16:	00054783          	lbu	a5,0(a0)
    3c1a:	fbfd                	bnez	a5,3c10 <strchr+0xc>
      return (char*)s;
  return 0;
    3c1c:	4501                	li	a0,0
}
    3c1e:	6422                	ld	s0,8(sp)
    3c20:	0141                	addi	sp,sp,16
    3c22:	8082                	ret
  return 0;
    3c24:	4501                	li	a0,0
    3c26:	bfe5                	j	3c1e <strchr+0x1a>

0000000000003c28 <gets>:

char*
gets(char *buf, int max)
{
    3c28:	711d                	addi	sp,sp,-96
    3c2a:	ec86                	sd	ra,88(sp)
    3c2c:	e8a2                	sd	s0,80(sp)
    3c2e:	e4a6                	sd	s1,72(sp)
    3c30:	e0ca                	sd	s2,64(sp)
    3c32:	fc4e                	sd	s3,56(sp)
    3c34:	f852                	sd	s4,48(sp)
    3c36:	f456                	sd	s5,40(sp)
    3c38:	f05a                	sd	s6,32(sp)
    3c3a:	ec5e                	sd	s7,24(sp)
    3c3c:	1080                	addi	s0,sp,96
    3c3e:	8baa                	mv	s7,a0
    3c40:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3c42:	892a                	mv	s2,a0
    3c44:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    3c46:	4aa9                	li	s5,10
    3c48:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    3c4a:	89a6                	mv	s3,s1
    3c4c:	2485                	addiw	s1,s1,1
    3c4e:	0344d863          	bge	s1,s4,3c7e <gets+0x56>
    cc = read(0, &c, 1);
    3c52:	4605                	li	a2,1
    3c54:	faf40593          	addi	a1,s0,-81
    3c58:	4501                	li	a0,0
    3c5a:	00000097          	auipc	ra,0x0
    3c5e:	1fc080e7          	jalr	508(ra) # 3e56 <read>
    if(cc < 1)
    3c62:	00a05e63          	blez	a0,3c7e <gets+0x56>
    buf[i++] = c;
    3c66:	faf44783          	lbu	a5,-81(s0)
    3c6a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    3c6e:	01578763          	beq	a5,s5,3c7c <gets+0x54>
    3c72:	0905                	addi	s2,s2,1
    3c74:	fd679be3          	bne	a5,s6,3c4a <gets+0x22>
  for(i=0; i+1 < max; ){
    3c78:	89a6                	mv	s3,s1
    3c7a:	a011                	j	3c7e <gets+0x56>
    3c7c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    3c7e:	99de                	add	s3,s3,s7
    3c80:	00098023          	sb	zero,0(s3)
  return buf;
}
    3c84:	855e                	mv	a0,s7
    3c86:	60e6                	ld	ra,88(sp)
    3c88:	6446                	ld	s0,80(sp)
    3c8a:	64a6                	ld	s1,72(sp)
    3c8c:	6906                	ld	s2,64(sp)
    3c8e:	79e2                	ld	s3,56(sp)
    3c90:	7a42                	ld	s4,48(sp)
    3c92:	7aa2                	ld	s5,40(sp)
    3c94:	7b02                	ld	s6,32(sp)
    3c96:	6be2                	ld	s7,24(sp)
    3c98:	6125                	addi	sp,sp,96
    3c9a:	8082                	ret

0000000000003c9c <stat>:

int
stat(const char *n, struct stat *st)
{
    3c9c:	1101                	addi	sp,sp,-32
    3c9e:	ec06                	sd	ra,24(sp)
    3ca0:	e822                	sd	s0,16(sp)
    3ca2:	e426                	sd	s1,8(sp)
    3ca4:	e04a                	sd	s2,0(sp)
    3ca6:	1000                	addi	s0,sp,32
    3ca8:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3caa:	4581                	li	a1,0
    3cac:	00000097          	auipc	ra,0x0
    3cb0:	1d2080e7          	jalr	466(ra) # 3e7e <open>
  if(fd < 0)
    3cb4:	02054563          	bltz	a0,3cde <stat+0x42>
    3cb8:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    3cba:	85ca                	mv	a1,s2
    3cbc:	00000097          	auipc	ra,0x0
    3cc0:	1da080e7          	jalr	474(ra) # 3e96 <fstat>
    3cc4:	892a                	mv	s2,a0
  close(fd);
    3cc6:	8526                	mv	a0,s1
    3cc8:	00000097          	auipc	ra,0x0
    3ccc:	19e080e7          	jalr	414(ra) # 3e66 <close>
  return r;
}
    3cd0:	854a                	mv	a0,s2
    3cd2:	60e2                	ld	ra,24(sp)
    3cd4:	6442                	ld	s0,16(sp)
    3cd6:	64a2                	ld	s1,8(sp)
    3cd8:	6902                	ld	s2,0(sp)
    3cda:	6105                	addi	sp,sp,32
    3cdc:	8082                	ret
    return -1;
    3cde:	597d                	li	s2,-1
    3ce0:	bfc5                	j	3cd0 <stat+0x34>

0000000000003ce2 <atoi>:

int
atoi(const char *s)
{
    3ce2:	1141                	addi	sp,sp,-16
    3ce4:	e422                	sd	s0,8(sp)
    3ce6:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3ce8:	00054603          	lbu	a2,0(a0)
    3cec:	fd06079b          	addiw	a5,a2,-48
    3cf0:	0ff7f793          	andi	a5,a5,255
    3cf4:	4725                	li	a4,9
    3cf6:	02f76963          	bltu	a4,a5,3d28 <atoi+0x46>
    3cfa:	86aa                	mv	a3,a0
  n = 0;
    3cfc:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
    3cfe:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
    3d00:	0685                	addi	a3,a3,1
    3d02:	0025179b          	slliw	a5,a0,0x2
    3d06:	9fa9                	addw	a5,a5,a0
    3d08:	0017979b          	slliw	a5,a5,0x1
    3d0c:	9fb1                	addw	a5,a5,a2
    3d0e:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    3d12:	0006c603          	lbu	a2,0(a3)
    3d16:	fd06071b          	addiw	a4,a2,-48
    3d1a:	0ff77713          	andi	a4,a4,255
    3d1e:	fee5f1e3          	bgeu	a1,a4,3d00 <atoi+0x1e>
  return n;
}
    3d22:	6422                	ld	s0,8(sp)
    3d24:	0141                	addi	sp,sp,16
    3d26:	8082                	ret
  n = 0;
    3d28:	4501                	li	a0,0
    3d2a:	bfe5                	j	3d22 <atoi+0x40>

0000000000003d2c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3d2c:	1141                	addi	sp,sp,-16
    3d2e:	e422                	sd	s0,8(sp)
    3d30:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    3d32:	02b57463          	bgeu	a0,a1,3d5a <memmove+0x2e>
    while(n-- > 0)
    3d36:	00c05f63          	blez	a2,3d54 <memmove+0x28>
    3d3a:	1602                	slli	a2,a2,0x20
    3d3c:	9201                	srli	a2,a2,0x20
    3d3e:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    3d42:	872a                	mv	a4,a0
      *dst++ = *src++;
    3d44:	0585                	addi	a1,a1,1
    3d46:	0705                	addi	a4,a4,1
    3d48:	fff5c683          	lbu	a3,-1(a1)
    3d4c:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    3d50:	fee79ae3          	bne	a5,a4,3d44 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    3d54:	6422                	ld	s0,8(sp)
    3d56:	0141                	addi	sp,sp,16
    3d58:	8082                	ret
    dst += n;
    3d5a:	00c50733          	add	a4,a0,a2
    src += n;
    3d5e:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    3d60:	fec05ae3          	blez	a2,3d54 <memmove+0x28>
    3d64:	fff6079b          	addiw	a5,a2,-1
    3d68:	1782                	slli	a5,a5,0x20
    3d6a:	9381                	srli	a5,a5,0x20
    3d6c:	fff7c793          	not	a5,a5
    3d70:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    3d72:	15fd                	addi	a1,a1,-1
    3d74:	177d                	addi	a4,a4,-1
    3d76:	0005c683          	lbu	a3,0(a1)
    3d7a:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    3d7e:	fee79ae3          	bne	a5,a4,3d72 <memmove+0x46>
    3d82:	bfc9                	j	3d54 <memmove+0x28>

0000000000003d84 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    3d84:	1141                	addi	sp,sp,-16
    3d86:	e422                	sd	s0,8(sp)
    3d88:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    3d8a:	ca05                	beqz	a2,3dba <memcmp+0x36>
    3d8c:	fff6069b          	addiw	a3,a2,-1
    3d90:	1682                	slli	a3,a3,0x20
    3d92:	9281                	srli	a3,a3,0x20
    3d94:	0685                	addi	a3,a3,1
    3d96:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    3d98:	00054783          	lbu	a5,0(a0)
    3d9c:	0005c703          	lbu	a4,0(a1)
    3da0:	00e79863          	bne	a5,a4,3db0 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    3da4:	0505                	addi	a0,a0,1
    p2++;
    3da6:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    3da8:	fed518e3          	bne	a0,a3,3d98 <memcmp+0x14>
  }
  return 0;
    3dac:	4501                	li	a0,0
    3dae:	a019                	j	3db4 <memcmp+0x30>
      return *p1 - *p2;
    3db0:	40e7853b          	subw	a0,a5,a4
}
    3db4:	6422                	ld	s0,8(sp)
    3db6:	0141                	addi	sp,sp,16
    3db8:	8082                	ret
  return 0;
    3dba:	4501                	li	a0,0
    3dbc:	bfe5                	j	3db4 <memcmp+0x30>

0000000000003dbe <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    3dbe:	1141                	addi	sp,sp,-16
    3dc0:	e406                	sd	ra,8(sp)
    3dc2:	e022                	sd	s0,0(sp)
    3dc4:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    3dc6:	00000097          	auipc	ra,0x0
    3dca:	f66080e7          	jalr	-154(ra) # 3d2c <memmove>
}
    3dce:	60a2                	ld	ra,8(sp)
    3dd0:	6402                	ld	s0,0(sp)
    3dd2:	0141                	addi	sp,sp,16
    3dd4:	8082                	ret

0000000000003dd6 <init_lock>:

void init_lock(struct spinlock * lk) 
{   
    3dd6:	1141                	addi	sp,sp,-16
    3dd8:	e422                	sd	s0,8(sp)
    3dda:	0800                	addi	s0,sp,16
  lk->locked = 0; 
    3ddc:	00052023          	sw	zero,0(a0)
}  
    3de0:	6422                	ld	s0,8(sp)
    3de2:	0141                	addi	sp,sp,16
    3de4:	8082                	ret

0000000000003de6 <lock>:

void lock(struct spinlock * lk) 
{    
    3de6:	1141                	addi	sp,sp,-16
    3de8:	e422                	sd	s0,8(sp)
    3dea:	0800                	addi	s0,sp,16
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0) ; 
    3dec:	4705                	li	a4,1
    3dee:	87ba                	mv	a5,a4
    3df0:	0cf527af          	amoswap.w.aq	a5,a5,(a0)
    3df4:	2781                	sext.w	a5,a5
    3df6:	ffe5                	bnez	a5,3dee <lock+0x8>
}  
    3df8:	6422                	ld	s0,8(sp)
    3dfa:	0141                	addi	sp,sp,16
    3dfc:	8082                	ret

0000000000003dfe <unlock>:

void unlock(struct spinlock * lk) 
{   
    3dfe:	1141                	addi	sp,sp,-16
    3e00:	e422                	sd	s0,8(sp)
    3e02:	0800                	addi	s0,sp,16
  // __sync_lock_release(&lk->locked, 0); 
  __sync_lock_release(&lk->locked); 
    3e04:	0f50000f          	fence	iorw,ow
    3e08:	0805202f          	amoswap.w	zero,zero,(a0)
} 
    3e0c:	6422                	ld	s0,8(sp)
    3e0e:	0141                	addi	sp,sp,16
    3e10:	8082                	ret

0000000000003e12 <isDigit>:

unsigned int isDigit(char *c) {
    3e12:	1141                	addi	sp,sp,-16
    3e14:	e422                	sd	s0,8(sp)
    3e16:	0800                	addi	s0,sp,16
  if (*c >= '0' && *c <= '9') 
    3e18:	00054503          	lbu	a0,0(a0)
    3e1c:	fd05051b          	addiw	a0,a0,-48
    3e20:	0ff57513          	andi	a0,a0,255
    return 1; 
  return 0; 
}
    3e24:	00a53513          	sltiu	a0,a0,10
    3e28:	6422                	ld	s0,8(sp)
    3e2a:	0141                	addi	sp,sp,16
    3e2c:	8082                	ret

0000000000003e2e <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    3e2e:	4885                	li	a7,1
 ecall
    3e30:	00000073          	ecall
 ret
    3e34:	8082                	ret

0000000000003e36 <exit>:
.global exit
exit:
 li a7, SYS_exit
    3e36:	4889                	li	a7,2
 ecall
    3e38:	00000073          	ecall
 ret
    3e3c:	8082                	ret

0000000000003e3e <wait>:
.global wait
wait:
 li a7, SYS_wait
    3e3e:	488d                	li	a7,3
 ecall
    3e40:	00000073          	ecall
 ret
    3e44:	8082                	ret

0000000000003e46 <waitx>:
.global waitx
waitx:
 li a7, SYS_waitx
    3e46:	48e1                	li	a7,24
 ecall
    3e48:	00000073          	ecall
 ret
    3e4c:	8082                	ret

0000000000003e4e <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    3e4e:	4891                	li	a7,4
 ecall
    3e50:	00000073          	ecall
 ret
    3e54:	8082                	ret

0000000000003e56 <read>:
.global read
read:
 li a7, SYS_read
    3e56:	4895                	li	a7,5
 ecall
    3e58:	00000073          	ecall
 ret
    3e5c:	8082                	ret

0000000000003e5e <write>:
.global write
write:
 li a7, SYS_write
    3e5e:	48c1                	li	a7,16
 ecall
    3e60:	00000073          	ecall
 ret
    3e64:	8082                	ret

0000000000003e66 <close>:
.global close
close:
 li a7, SYS_close
    3e66:	48d5                	li	a7,21
 ecall
    3e68:	00000073          	ecall
 ret
    3e6c:	8082                	ret

0000000000003e6e <kill>:
.global kill
kill:
 li a7, SYS_kill
    3e6e:	4899                	li	a7,6
 ecall
    3e70:	00000073          	ecall
 ret
    3e74:	8082                	ret

0000000000003e76 <exec>:
.global exec
exec:
 li a7, SYS_exec
    3e76:	489d                	li	a7,7
 ecall
    3e78:	00000073          	ecall
 ret
    3e7c:	8082                	ret

0000000000003e7e <open>:
.global open
open:
 li a7, SYS_open
    3e7e:	48bd                	li	a7,15
 ecall
    3e80:	00000073          	ecall
 ret
    3e84:	8082                	ret

0000000000003e86 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    3e86:	48c5                	li	a7,17
 ecall
    3e88:	00000073          	ecall
 ret
    3e8c:	8082                	ret

0000000000003e8e <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    3e8e:	48c9                	li	a7,18
 ecall
    3e90:	00000073          	ecall
 ret
    3e94:	8082                	ret

0000000000003e96 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    3e96:	48a1                	li	a7,8
 ecall
    3e98:	00000073          	ecall
 ret
    3e9c:	8082                	ret

0000000000003e9e <link>:
.global link
link:
 li a7, SYS_link
    3e9e:	48cd                	li	a7,19
 ecall
    3ea0:	00000073          	ecall
 ret
    3ea4:	8082                	ret

0000000000003ea6 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    3ea6:	48d1                	li	a7,20
 ecall
    3ea8:	00000073          	ecall
 ret
    3eac:	8082                	ret

0000000000003eae <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    3eae:	48a5                	li	a7,9
 ecall
    3eb0:	00000073          	ecall
 ret
    3eb4:	8082                	ret

0000000000003eb6 <dup>:
.global dup
dup:
 li a7, SYS_dup
    3eb6:	48a9                	li	a7,10
 ecall
    3eb8:	00000073          	ecall
 ret
    3ebc:	8082                	ret

0000000000003ebe <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    3ebe:	48ad                	li	a7,11
 ecall
    3ec0:	00000073          	ecall
 ret
    3ec4:	8082                	ret

0000000000003ec6 <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    3ec6:	48b1                	li	a7,12
 ecall
    3ec8:	00000073          	ecall
 ret
    3ecc:	8082                	ret

0000000000003ece <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    3ece:	48b5                	li	a7,13
 ecall
    3ed0:	00000073          	ecall
 ret
    3ed4:	8082                	ret

0000000000003ed6 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    3ed6:	48b9                	li	a7,14
 ecall
    3ed8:	00000073          	ecall
 ret
    3edc:	8082                	ret

0000000000003ede <uniq_k>:
.global uniq_k
uniq_k:
 li a7, SYS_uniq_k
    3ede:	48d9                	li	a7,22
 ecall
    3ee0:	00000073          	ecall
 ret
    3ee4:	8082                	ret

0000000000003ee6 <head_k>:
.global head_k
head_k:
 li a7, SYS_head_k
    3ee6:	48dd                	li	a7,23
 ecall
    3ee8:	00000073          	ecall
 ret
    3eec:	8082                	ret

0000000000003eee <ps>:
.global ps
ps:
 li a7, SYS_ps
    3eee:	48e5                	li	a7,25
 ecall
    3ef0:	00000073          	ecall
 ret
    3ef4:	8082                	ret

0000000000003ef6 <set_scheduler>:
.global set_scheduler
set_scheduler:
 li a7, SYS_set_scheduler
    3ef6:	48e9                	li	a7,26
 ecall
    3ef8:	00000073          	ecall
 ret
    3efc:	8082                	ret

0000000000003efe <set_priority>:
.global set_priority
set_priority:
 li a7, SYS_set_priority
    3efe:	48ed                	li	a7,27
 ecall
    3f00:	00000073          	ecall
 ret
    3f04:	8082                	ret

0000000000003f06 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    3f06:	1101                	addi	sp,sp,-32
    3f08:	ec06                	sd	ra,24(sp)
    3f0a:	e822                	sd	s0,16(sp)
    3f0c:	1000                	addi	s0,sp,32
    3f0e:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    3f12:	4605                	li	a2,1
    3f14:	fef40593          	addi	a1,s0,-17
    3f18:	00000097          	auipc	ra,0x0
    3f1c:	f46080e7          	jalr	-186(ra) # 3e5e <write>
}
    3f20:	60e2                	ld	ra,24(sp)
    3f22:	6442                	ld	s0,16(sp)
    3f24:	6105                	addi	sp,sp,32
    3f26:	8082                	ret

0000000000003f28 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    3f28:	7139                	addi	sp,sp,-64
    3f2a:	fc06                	sd	ra,56(sp)
    3f2c:	f822                	sd	s0,48(sp)
    3f2e:	f426                	sd	s1,40(sp)
    3f30:	f04a                	sd	s2,32(sp)
    3f32:	ec4e                	sd	s3,24(sp)
    3f34:	0080                	addi	s0,sp,64
    3f36:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3f38:	c299                	beqz	a3,3f3e <printint+0x16>
    3f3a:	0805c863          	bltz	a1,3fca <printint+0xa2>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    3f3e:	2581                	sext.w	a1,a1
  neg = 0;
    3f40:	4881                	li	a7,0
    3f42:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    3f46:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    3f48:	2601                	sext.w	a2,a2
    3f4a:	00000517          	auipc	a0,0x0
    3f4e:	57e50513          	addi	a0,a0,1406 # 44c8 <digits>
    3f52:	883a                	mv	a6,a4
    3f54:	2705                	addiw	a4,a4,1
    3f56:	02c5f7bb          	remuw	a5,a1,a2
    3f5a:	1782                	slli	a5,a5,0x20
    3f5c:	9381                	srli	a5,a5,0x20
    3f5e:	97aa                	add	a5,a5,a0
    3f60:	0007c783          	lbu	a5,0(a5)
    3f64:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    3f68:	0005879b          	sext.w	a5,a1
    3f6c:	02c5d5bb          	divuw	a1,a1,a2
    3f70:	0685                	addi	a3,a3,1
    3f72:	fec7f0e3          	bgeu	a5,a2,3f52 <printint+0x2a>
  if(neg)
    3f76:	00088b63          	beqz	a7,3f8c <printint+0x64>
    buf[i++] = '-';
    3f7a:	fd040793          	addi	a5,s0,-48
    3f7e:	973e                	add	a4,a4,a5
    3f80:	02d00793          	li	a5,45
    3f84:	fef70823          	sb	a5,-16(a4)
    3f88:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    3f8c:	02e05863          	blez	a4,3fbc <printint+0x94>
    3f90:	fc040793          	addi	a5,s0,-64
    3f94:	00e78933          	add	s2,a5,a4
    3f98:	fff78993          	addi	s3,a5,-1
    3f9c:	99ba                	add	s3,s3,a4
    3f9e:	377d                	addiw	a4,a4,-1
    3fa0:	1702                	slli	a4,a4,0x20
    3fa2:	9301                	srli	a4,a4,0x20
    3fa4:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    3fa8:	fff94583          	lbu	a1,-1(s2)
    3fac:	8526                	mv	a0,s1
    3fae:	00000097          	auipc	ra,0x0
    3fb2:	f58080e7          	jalr	-168(ra) # 3f06 <putc>
  while(--i >= 0)
    3fb6:	197d                	addi	s2,s2,-1
    3fb8:	ff3918e3          	bne	s2,s3,3fa8 <printint+0x80>
}
    3fbc:	70e2                	ld	ra,56(sp)
    3fbe:	7442                	ld	s0,48(sp)
    3fc0:	74a2                	ld	s1,40(sp)
    3fc2:	7902                	ld	s2,32(sp)
    3fc4:	69e2                	ld	s3,24(sp)
    3fc6:	6121                	addi	sp,sp,64
    3fc8:	8082                	ret
    x = -xx;
    3fca:	40b005bb          	negw	a1,a1
    neg = 1;
    3fce:	4885                	li	a7,1
    x = -xx;
    3fd0:	bf8d                	j	3f42 <printint+0x1a>

0000000000003fd2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    3fd2:	7119                	addi	sp,sp,-128
    3fd4:	fc86                	sd	ra,120(sp)
    3fd6:	f8a2                	sd	s0,112(sp)
    3fd8:	f4a6                	sd	s1,104(sp)
    3fda:	f0ca                	sd	s2,96(sp)
    3fdc:	ecce                	sd	s3,88(sp)
    3fde:	e8d2                	sd	s4,80(sp)
    3fe0:	e4d6                	sd	s5,72(sp)
    3fe2:	e0da                	sd	s6,64(sp)
    3fe4:	fc5e                	sd	s7,56(sp)
    3fe6:	f862                	sd	s8,48(sp)
    3fe8:	f466                	sd	s9,40(sp)
    3fea:	f06a                	sd	s10,32(sp)
    3fec:	ec6e                	sd	s11,24(sp)
    3fee:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    3ff0:	0005c903          	lbu	s2,0(a1)
    3ff4:	18090f63          	beqz	s2,4192 <vprintf+0x1c0>
    3ff8:	8aaa                	mv	s5,a0
    3ffa:	8b32                	mv	s6,a2
    3ffc:	00158493          	addi	s1,a1,1
  state = 0;
    4000:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    4002:	02500a13          	li	s4,37
      if(c == 'd'){
    4006:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c == 'l') {
    400a:	06c00c93          	li	s9,108
        printint(fd, va_arg(ap, uint64), 10, 0);
      } else if(c == 'x') {
    400e:	07800d13          	li	s10,120
        printint(fd, va_arg(ap, int), 16, 0);
      } else if(c == 'p') {
    4012:	07000d93          	li	s11,112
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    4016:	00000b97          	auipc	s7,0x0
    401a:	4b2b8b93          	addi	s7,s7,1202 # 44c8 <digits>
    401e:	a839                	j	403c <vprintf+0x6a>
        putc(fd, c);
    4020:	85ca                	mv	a1,s2
    4022:	8556                	mv	a0,s5
    4024:	00000097          	auipc	ra,0x0
    4028:	ee2080e7          	jalr	-286(ra) # 3f06 <putc>
    402c:	a019                	j	4032 <vprintf+0x60>
    } else if(state == '%'){
    402e:	01498f63          	beq	s3,s4,404c <vprintf+0x7a>
  for(i = 0; fmt[i]; i++){
    4032:	0485                	addi	s1,s1,1
    4034:	fff4c903          	lbu	s2,-1(s1)
    4038:	14090d63          	beqz	s2,4192 <vprintf+0x1c0>
    c = fmt[i] & 0xff;
    403c:	0009079b          	sext.w	a5,s2
    if(state == 0){
    4040:	fe0997e3          	bnez	s3,402e <vprintf+0x5c>
      if(c == '%'){
    4044:	fd479ee3          	bne	a5,s4,4020 <vprintf+0x4e>
        state = '%';
    4048:	89be                	mv	s3,a5
    404a:	b7e5                	j	4032 <vprintf+0x60>
      if(c == 'd'){
    404c:	05878063          	beq	a5,s8,408c <vprintf+0xba>
      } else if(c == 'l') {
    4050:	05978c63          	beq	a5,s9,40a8 <vprintf+0xd6>
      } else if(c == 'x') {
    4054:	07a78863          	beq	a5,s10,40c4 <vprintf+0xf2>
      } else if(c == 'p') {
    4058:	09b78463          	beq	a5,s11,40e0 <vprintf+0x10e>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
    405c:	07300713          	li	a4,115
    4060:	0ce78663          	beq	a5,a4,412c <vprintf+0x15a>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    4064:	06300713          	li	a4,99
    4068:	0ee78e63          	beq	a5,a4,4164 <vprintf+0x192>
        putc(fd, va_arg(ap, uint));
      } else if(c == '%'){
    406c:	11478863          	beq	a5,s4,417c <vprintf+0x1aa>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    4070:	85d2                	mv	a1,s4
    4072:	8556                	mv	a0,s5
    4074:	00000097          	auipc	ra,0x0
    4078:	e92080e7          	jalr	-366(ra) # 3f06 <putc>
        putc(fd, c);
    407c:	85ca                	mv	a1,s2
    407e:	8556                	mv	a0,s5
    4080:	00000097          	auipc	ra,0x0
    4084:	e86080e7          	jalr	-378(ra) # 3f06 <putc>
      }
      state = 0;
    4088:	4981                	li	s3,0
    408a:	b765                	j	4032 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 10, 1);
    408c:	008b0913          	addi	s2,s6,8
    4090:	4685                	li	a3,1
    4092:	4629                	li	a2,10
    4094:	000b2583          	lw	a1,0(s6)
    4098:	8556                	mv	a0,s5
    409a:	00000097          	auipc	ra,0x0
    409e:	e8e080e7          	jalr	-370(ra) # 3f28 <printint>
    40a2:	8b4a                	mv	s6,s2
      state = 0;
    40a4:	4981                	li	s3,0
    40a6:	b771                	j	4032 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    40a8:	008b0913          	addi	s2,s6,8
    40ac:	4681                	li	a3,0
    40ae:	4629                	li	a2,10
    40b0:	000b2583          	lw	a1,0(s6)
    40b4:	8556                	mv	a0,s5
    40b6:	00000097          	auipc	ra,0x0
    40ba:	e72080e7          	jalr	-398(ra) # 3f28 <printint>
    40be:	8b4a                	mv	s6,s2
      state = 0;
    40c0:	4981                	li	s3,0
    40c2:	bf85                	j	4032 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    40c4:	008b0913          	addi	s2,s6,8
    40c8:	4681                	li	a3,0
    40ca:	4641                	li	a2,16
    40cc:	000b2583          	lw	a1,0(s6)
    40d0:	8556                	mv	a0,s5
    40d2:	00000097          	auipc	ra,0x0
    40d6:	e56080e7          	jalr	-426(ra) # 3f28 <printint>
    40da:	8b4a                	mv	s6,s2
      state = 0;
    40dc:	4981                	li	s3,0
    40de:	bf91                	j	4032 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    40e0:	008b0793          	addi	a5,s6,8
    40e4:	f8f43423          	sd	a5,-120(s0)
    40e8:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    40ec:	03000593          	li	a1,48
    40f0:	8556                	mv	a0,s5
    40f2:	00000097          	auipc	ra,0x0
    40f6:	e14080e7          	jalr	-492(ra) # 3f06 <putc>
  putc(fd, 'x');
    40fa:	85ea                	mv	a1,s10
    40fc:	8556                	mv	a0,s5
    40fe:	00000097          	auipc	ra,0x0
    4102:	e08080e7          	jalr	-504(ra) # 3f06 <putc>
    4106:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    4108:	03c9d793          	srli	a5,s3,0x3c
    410c:	97de                	add	a5,a5,s7
    410e:	0007c583          	lbu	a1,0(a5)
    4112:	8556                	mv	a0,s5
    4114:	00000097          	auipc	ra,0x0
    4118:	df2080e7          	jalr	-526(ra) # 3f06 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    411c:	0992                	slli	s3,s3,0x4
    411e:	397d                	addiw	s2,s2,-1
    4120:	fe0914e3          	bnez	s2,4108 <vprintf+0x136>
        printptr(fd, va_arg(ap, uint64));
    4124:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    4128:	4981                	li	s3,0
    412a:	b721                	j	4032 <vprintf+0x60>
        s = va_arg(ap, char*);
    412c:	008b0993          	addi	s3,s6,8
    4130:	000b3903          	ld	s2,0(s6)
        if(s == 0)
    4134:	02090163          	beqz	s2,4156 <vprintf+0x184>
        while(*s != 0){
    4138:	00094583          	lbu	a1,0(s2)
    413c:	c9a1                	beqz	a1,418c <vprintf+0x1ba>
          putc(fd, *s);
    413e:	8556                	mv	a0,s5
    4140:	00000097          	auipc	ra,0x0
    4144:	dc6080e7          	jalr	-570(ra) # 3f06 <putc>
          s++;
    4148:	0905                	addi	s2,s2,1
        while(*s != 0){
    414a:	00094583          	lbu	a1,0(s2)
    414e:	f9e5                	bnez	a1,413e <vprintf+0x16c>
        s = va_arg(ap, char*);
    4150:	8b4e                	mv	s6,s3
      state = 0;
    4152:	4981                	li	s3,0
    4154:	bdf9                	j	4032 <vprintf+0x60>
          s = "(null)";
    4156:	00000917          	auipc	s2,0x0
    415a:	36a90913          	addi	s2,s2,874 # 44c0 <malloc+0x224>
        while(*s != 0){
    415e:	02800593          	li	a1,40
    4162:	bff1                	j	413e <vprintf+0x16c>
        putc(fd, va_arg(ap, uint));
    4164:	008b0913          	addi	s2,s6,8
    4168:	000b4583          	lbu	a1,0(s6)
    416c:	8556                	mv	a0,s5
    416e:	00000097          	auipc	ra,0x0
    4172:	d98080e7          	jalr	-616(ra) # 3f06 <putc>
    4176:	8b4a                	mv	s6,s2
      state = 0;
    4178:	4981                	li	s3,0
    417a:	bd65                	j	4032 <vprintf+0x60>
        putc(fd, c);
    417c:	85d2                	mv	a1,s4
    417e:	8556                	mv	a0,s5
    4180:	00000097          	auipc	ra,0x0
    4184:	d86080e7          	jalr	-634(ra) # 3f06 <putc>
      state = 0;
    4188:	4981                	li	s3,0
    418a:	b565                	j	4032 <vprintf+0x60>
        s = va_arg(ap, char*);
    418c:	8b4e                	mv	s6,s3
      state = 0;
    418e:	4981                	li	s3,0
    4190:	b54d                	j	4032 <vprintf+0x60>
    }
  }
}
    4192:	70e6                	ld	ra,120(sp)
    4194:	7446                	ld	s0,112(sp)
    4196:	74a6                	ld	s1,104(sp)
    4198:	7906                	ld	s2,96(sp)
    419a:	69e6                	ld	s3,88(sp)
    419c:	6a46                	ld	s4,80(sp)
    419e:	6aa6                	ld	s5,72(sp)
    41a0:	6b06                	ld	s6,64(sp)
    41a2:	7be2                	ld	s7,56(sp)
    41a4:	7c42                	ld	s8,48(sp)
    41a6:	7ca2                	ld	s9,40(sp)
    41a8:	7d02                	ld	s10,32(sp)
    41aa:	6de2                	ld	s11,24(sp)
    41ac:	6109                	addi	sp,sp,128
    41ae:	8082                	ret

00000000000041b0 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    41b0:	715d                	addi	sp,sp,-80
    41b2:	ec06                	sd	ra,24(sp)
    41b4:	e822                	sd	s0,16(sp)
    41b6:	1000                	addi	s0,sp,32
    41b8:	e010                	sd	a2,0(s0)
    41ba:	e414                	sd	a3,8(s0)
    41bc:	e818                	sd	a4,16(s0)
    41be:	ec1c                	sd	a5,24(s0)
    41c0:	03043023          	sd	a6,32(s0)
    41c4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    41c8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    41cc:	8622                	mv	a2,s0
    41ce:	00000097          	auipc	ra,0x0
    41d2:	e04080e7          	jalr	-508(ra) # 3fd2 <vprintf>
}
    41d6:	60e2                	ld	ra,24(sp)
    41d8:	6442                	ld	s0,16(sp)
    41da:	6161                	addi	sp,sp,80
    41dc:	8082                	ret

00000000000041de <printf>:

void
printf(const char *fmt, ...)
{
    41de:	711d                	addi	sp,sp,-96
    41e0:	ec06                	sd	ra,24(sp)
    41e2:	e822                	sd	s0,16(sp)
    41e4:	1000                	addi	s0,sp,32
    41e6:	e40c                	sd	a1,8(s0)
    41e8:	e810                	sd	a2,16(s0)
    41ea:	ec14                	sd	a3,24(s0)
    41ec:	f018                	sd	a4,32(s0)
    41ee:	f41c                	sd	a5,40(s0)
    41f0:	03043823          	sd	a6,48(s0)
    41f4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    41f8:	00840613          	addi	a2,s0,8
    41fc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    4200:	85aa                	mv	a1,a0
    4202:	4505                	li	a0,1
    4204:	00000097          	auipc	ra,0x0
    4208:	dce080e7          	jalr	-562(ra) # 3fd2 <vprintf>
}
    420c:	60e2                	ld	ra,24(sp)
    420e:	6442                	ld	s0,16(sp)
    4210:	6125                	addi	sp,sp,96
    4212:	8082                	ret

0000000000004214 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    4214:	1141                	addi	sp,sp,-16
    4216:	e422                	sd	s0,8(sp)
    4218:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    421a:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    421e:	00001797          	auipc	a5,0x1
    4222:	df27b783          	ld	a5,-526(a5) # 5010 <freep>
    4226:	a805                	j	4256 <free+0x42>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    4228:	4618                	lw	a4,8(a2)
    422a:	9db9                	addw	a1,a1,a4
    422c:	feb52c23          	sw	a1,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    4230:	6398                	ld	a4,0(a5)
    4232:	6318                	ld	a4,0(a4)
    4234:	fee53823          	sd	a4,-16(a0)
    4238:	a091                	j	427c <free+0x68>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    423a:	ff852703          	lw	a4,-8(a0)
    423e:	9e39                	addw	a2,a2,a4
    4240:	c790                	sw	a2,8(a5)
    p->s.ptr = bp->s.ptr;
    4242:	ff053703          	ld	a4,-16(a0)
    4246:	e398                	sd	a4,0(a5)
    4248:	a099                	j	428e <free+0x7a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    424a:	6398                	ld	a4,0(a5)
    424c:	00e7e463          	bltu	a5,a4,4254 <free+0x40>
    4250:	00e6ea63          	bltu	a3,a4,4264 <free+0x50>
{
    4254:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4256:	fed7fae3          	bgeu	a5,a3,424a <free+0x36>
    425a:	6398                	ld	a4,0(a5)
    425c:	00e6e463          	bltu	a3,a4,4264 <free+0x50>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4260:	fee7eae3          	bltu	a5,a4,4254 <free+0x40>
  if(bp + bp->s.size == p->s.ptr){
    4264:	ff852583          	lw	a1,-8(a0)
    4268:	6390                	ld	a2,0(a5)
    426a:	02059713          	slli	a4,a1,0x20
    426e:	9301                	srli	a4,a4,0x20
    4270:	0712                	slli	a4,a4,0x4
    4272:	9736                	add	a4,a4,a3
    4274:	fae60ae3          	beq	a2,a4,4228 <free+0x14>
    bp->s.ptr = p->s.ptr;
    4278:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    427c:	4790                	lw	a2,8(a5)
    427e:	02061713          	slli	a4,a2,0x20
    4282:	9301                	srli	a4,a4,0x20
    4284:	0712                	slli	a4,a4,0x4
    4286:	973e                	add	a4,a4,a5
    4288:	fae689e3          	beq	a3,a4,423a <free+0x26>
  } else
    p->s.ptr = bp;
    428c:	e394                	sd	a3,0(a5)
  freep = p;
    428e:	00001717          	auipc	a4,0x1
    4292:	d8f73123          	sd	a5,-638(a4) # 5010 <freep>
}
    4296:	6422                	ld	s0,8(sp)
    4298:	0141                	addi	sp,sp,16
    429a:	8082                	ret

000000000000429c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    429c:	7139                	addi	sp,sp,-64
    429e:	fc06                	sd	ra,56(sp)
    42a0:	f822                	sd	s0,48(sp)
    42a2:	f426                	sd	s1,40(sp)
    42a4:	f04a                	sd	s2,32(sp)
    42a6:	ec4e                	sd	s3,24(sp)
    42a8:	e852                	sd	s4,16(sp)
    42aa:	e456                	sd	s5,8(sp)
    42ac:	e05a                	sd	s6,0(sp)
    42ae:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    42b0:	02051493          	slli	s1,a0,0x20
    42b4:	9081                	srli	s1,s1,0x20
    42b6:	04bd                	addi	s1,s1,15
    42b8:	8091                	srli	s1,s1,0x4
    42ba:	0014899b          	addiw	s3,s1,1
    42be:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    42c0:	00001517          	auipc	a0,0x1
    42c4:	d5053503          	ld	a0,-688(a0) # 5010 <freep>
    42c8:	c515                	beqz	a0,42f4 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    42ca:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    42cc:	4798                	lw	a4,8(a5)
    42ce:	02977f63          	bgeu	a4,s1,430c <malloc+0x70>
    42d2:	8a4e                	mv	s4,s3
    42d4:	0009871b          	sext.w	a4,s3
    42d8:	6685                	lui	a3,0x1
    42da:	00d77363          	bgeu	a4,a3,42e0 <malloc+0x44>
    42de:	6a05                	lui	s4,0x1
    42e0:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    42e4:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    42e8:	00001917          	auipc	s2,0x1
    42ec:	d2890913          	addi	s2,s2,-728 # 5010 <freep>
  if(p == (char*)-1)
    42f0:	5afd                	li	s5,-1
    42f2:	a88d                	j	4364 <malloc+0xc8>
    base.s.ptr = freep = prevp = &base;
    42f4:	00001797          	auipc	a5,0x1
    42f8:	d9478793          	addi	a5,a5,-620 # 5088 <base>
    42fc:	00001717          	auipc	a4,0x1
    4300:	d0f73a23          	sd	a5,-748(a4) # 5010 <freep>
    4304:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    4306:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    430a:	b7e1                	j	42d2 <malloc+0x36>
      if(p->s.size == nunits)
    430c:	02e48b63          	beq	s1,a4,4342 <malloc+0xa6>
        p->s.size -= nunits;
    4310:	4137073b          	subw	a4,a4,s3
    4314:	c798                	sw	a4,8(a5)
        p += p->s.size;
    4316:	1702                	slli	a4,a4,0x20
    4318:	9301                	srli	a4,a4,0x20
    431a:	0712                	slli	a4,a4,0x4
    431c:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    431e:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    4322:	00001717          	auipc	a4,0x1
    4326:	cea73723          	sd	a0,-786(a4) # 5010 <freep>
      return (void*)(p + 1);
    432a:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    432e:	70e2                	ld	ra,56(sp)
    4330:	7442                	ld	s0,48(sp)
    4332:	74a2                	ld	s1,40(sp)
    4334:	7902                	ld	s2,32(sp)
    4336:	69e2                	ld	s3,24(sp)
    4338:	6a42                	ld	s4,16(sp)
    433a:	6aa2                	ld	s5,8(sp)
    433c:	6b02                	ld	s6,0(sp)
    433e:	6121                	addi	sp,sp,64
    4340:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    4342:	6398                	ld	a4,0(a5)
    4344:	e118                	sd	a4,0(a0)
    4346:	bff1                	j	4322 <malloc+0x86>
  hp->s.size = nu;
    4348:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    434c:	0541                	addi	a0,a0,16
    434e:	00000097          	auipc	ra,0x0
    4352:	ec6080e7          	jalr	-314(ra) # 4214 <free>
  return freep;
    4356:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    435a:	d971                	beqz	a0,432e <malloc+0x92>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    435c:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    435e:	4798                	lw	a4,8(a5)
    4360:	fa9776e3          	bgeu	a4,s1,430c <malloc+0x70>
    if(p == freep)
    4364:	00093703          	ld	a4,0(s2)
    4368:	853e                	mv	a0,a5
    436a:	fef719e3          	bne	a4,a5,435c <malloc+0xc0>
  p = sbrk(nu * sizeof(Header));
    436e:	8552                	mv	a0,s4
    4370:	00000097          	auipc	ra,0x0
    4374:	b56080e7          	jalr	-1194(ra) # 3ec6 <sbrk>
  if(p == (char*)-1)
    4378:	fd5518e3          	bne	a0,s5,4348 <malloc+0xac>
        return 0;
    437c:	4501                	li	a0,0
    437e:	bf45                	j	432e <malloc+0x92>
