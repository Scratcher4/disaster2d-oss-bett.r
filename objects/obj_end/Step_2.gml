#macro END_ATTACK BALANCING+1
#macro END_AIR_ATTACK BALANCING+2
#macro END_SHOCKED BALANCING+3
#macro END_WON BALANCING+4
#macro END_LOST BALANCING+5
#macro END_ZIPLINE BALANCING+6

if(!emotion)
	state = IDLE;

if(won)
{
	if(isGrounded)
	{
		state = END_WON;
		return;
	}
}

if(lost)
{
	if(isGrounded)
	{
		state = END_LOST;
		return;
	}
}

if(isHurt)
{
	state = HURT;
	return;
}

if(shockedTimer > 0)
{
	if(!isGrounded)
		state = HURT;
	else
		state = END_SHOCKED;
	
	return;
}

if(isAttacking)
{
	if(isGrounded)
	{
		if(state == EXE_AIR_ATTACK)
		{
			isAttacking = false;
			return;
		}
		state = END_ATTACK;
	}
	else
	{
		if(state == END_ATTACK)
		{
			isAttacking = false;
			return;
		}
		state = END_AIR_ATTACK;
	}
	return;
}

if(isZipline)
{
	if(isGrounded)
		isZipline = false;
	
	state = END_ZIPLINE;
	return;
}

if(isLookingUp)
{
	state = LOOKUP;
	return;
}

if(isLookingDown)
{
	state = LOOKDOWN;
	return;
}

if(isSpinning)
{
	state = SPIN;
	return;
}

if(abs(xspd) > 0 && isGrounded)
{
	if(abs(xspd) < 8)
		state = WALK;
	else
		state = RUN;
}

if(isOnEdge)
{
	state = BALANCING;
	return;
}

if (!isGrounded) //in air
{
	if(isJumping)
		state = JUMP;
	else
		state = FALL;
}